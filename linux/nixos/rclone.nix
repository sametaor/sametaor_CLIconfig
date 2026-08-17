# rclone-mounts.nix
#
# Declarative replacement for manually running:
#   rclone mount onedrive: /data/onedrive/ --vfs-cache-mode full --allow-other --allow-non-empty --drive-acknowledge-abuse
#   rclone mount google-drive: /data/google-drive/ --allow-other --allow-non-empty --drive-acknowledge-abuse
#
# Runs as YOUR user, so it reads rclone.conf straight out of your home
# folder (~/.config/rclone/rclone.conf) — nothing to move or duplicate.

{
  config,
  lib,
  pkgs,
  ...
}:

let
  # <-- change this if your Linux username isn't "sametaor"
  username = "sametaor";

  userCfg = config.users.users.${username};
  rcloneConfigFile = "${userCfg.home}/.config/rclone/rclone.conf";

  mkRcloneMount =
    {
      remote,
      mountPoint,
      extraArgs ? [ ],
    }:
    {
      description = "Rclone mount for ${remote}";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      unitConfig.StartLimitIntervalSec = 0;

      serviceConfig = {
        Type = "notify";
        # Running as your own user so it can read your existing rclone.conf
        # directly. Group is left unset so systemd defaults to your primary
        # group automatically.
        User = username;
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount ${remote} ${mountPoint} \
            --config=${rcloneConfigFile} \
            --log-level INFO \
            ${lib.concatStringsSep " " extraArgs}
        '';
        ExecStop = "${pkgs.fuse}/bin/fusermount -uz ${mountPoint}";
        Restart = "on-failure";
        RestartSec = 10;
        Environment = "PATH=/run/wrappers/bin:${pkgs.fuse}/bin:${pkgs.coreutils}/bin";
      };
    };
in
{
  environment.systemPackages = [ pkgs.rclone ];

  # Required now: --allow-other is normally root-only. This lets a non-root
  # user (you) use it too, as long as /etc/fuse.conf has user_allow_other.
  programs.fuse.userAllowOther = true;

  # Create the mount point directories, owned by you, before the units run.
  systemd.tmpfiles.rules = [
    "d /data/onedrive 0755 ${username} ${userCfg.group} -"
    "d /data/google-drive 0755 ${username} ${userCfg.group} -"
  ];

  systemd.services."rclone-onedrive" = mkRcloneMount {
    remote = "onedrive:";
    mountPoint = "/data/onedrive";
    extraArgs = [
      "--vfs-cache-mode full"
      "--allow-other"
      "--allow-non-empty"
    ];
  };

  systemd.services."rclone-google-drive" = mkRcloneMount {
    remote = "google-drive:";
    mountPoint = "/data/google-drive";
    extraArgs = [
      "--allow-other"
      "--allow-non-empty"
      "--drive-acknowledge-abuse"
    ];
  };
}
