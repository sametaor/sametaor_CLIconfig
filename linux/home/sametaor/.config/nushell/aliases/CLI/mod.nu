# CLI Tools Module - lazy loads on first use
export module CLI_mod {
    export use Docker/mod.nu Docker_mod *
    export use Git/mod.nu Git_mod *
    export use Python/mod.nu Python_mod *
    export use ./conda.nu *
    export use ./eza.nu *
    export use ./github_cli.nu *
    export use ./gpg.nu *
    export use ./homebrew.nu *
    export use ./macports.nu *
    export use ./npm.nu *
    export use ./podman.nu *
    export use ./rsync.nu *
    export use ./ruby.nu *
    export use ./snap.nu *
    export use ./systemd.nu *
    export use ./tmuxinator.nu *
    export use ./vscodium.nu *
    export use ./yt-dlp.nu *
}
