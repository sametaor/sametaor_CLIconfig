# alg-rgb.nix
#
# Declarative packaging for https://github.com/24kaushik/alg-cli
# (native RGB keyboard control for Acer ALG AL15G-53 laptops).
#
# Import this file from your configuration.nix, e.g.:
#   imports = [ ./alg-rgb.nix ];
#
# First build will fail with a hash mismatch (the `lib.fakeHash`
# placeholders below) — copy the "got: sha256-..." value Nix prints
# into both `hash = ...` lines and rebuild. Both packages pull from
# the same commit, so it's one hash to fetch/copy.

{ config, pkgs, lib, ... }:

let
  # Pin to a specific commit for reproducibility. Bump this (and the
  # hash) when you want to pick up upstream changes.
  algRgbSrc = pkgs.fetchFromGitHub {
    owner = "24kaushik";
    repo = "alg-cli";
    rev = "4e7a8f9f82b77b8bb873f8238e85f2664997b769"; # latest main as of 2026-07-03
    hash = "sha256-sAF606G+roDOAnG5GW8G0UVknwRThav0TDphv3flvlQ="; # nix will tell you the real one on first build
  };

  # Out-of-tree kernel module, built against the currently selected
  # kernel package set so it stays in sync with `boot.kernelPackages`.
  algRgbKernelModule = config.boot.kernelPackages.callPackage
    ({ lib, stdenv, kernel }:
      stdenv.mkDerivation {
        pname = "alg-rgb-kernel-module";
        version = "0.1.3-unstable-2026-07-03";

        src = algRgbSrc;

        hardeningDisable = [ "pic" "format" ];

        nativeBuildInputs = kernel.moduleBuildDependencies;

        makeFlags = kernel.makeFlags ++ [
          "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
        ];

        buildPhase = ''
          runHook preBuild
          make -C kernel KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          installDir=$out/lib/modules/${kernel.modDirVersion}/extra
          install -Dm444 -t $installDir kernel/alg_rgb.ko
          runHook postInstall
        '';

        meta = with lib; {
          description = "Native Linux RGB keyboard control kernel module for Acer ALG laptops (CLV0001 ACPI interface)";
          homepage = "https://github.com/24kaushik/alg-cli";
          license = licenses.gpl2Only;
          platforms = platforms.linux;
        };
      })
    { };

  # Userspace CLI, plain gcc build.
  algRgbCli = pkgs.stdenv.mkDerivation {
    pname = "alg-rgb-cli";
    version = "0.1.3-unstable-2026-07-03";

    src = algRgbSrc;

    buildPhase = ''
      runHook preBuild
      make -C cli
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      install -Dm755 cli/alg-rgb $out/bin/alg-rgb
      runHook postInstall
    '';

    meta = with lib; {
      description = "CLI for controlling Acer ALG RGB keyboard backlight via /dev/alg_rgb";
      homepage = "https://github.com/24kaushik/alg-cli";
      license = licenses.gpl2Only;
      mainProgram = "alg-rgb";
      platforms = platforms.linux;
    };
  };
in
{
  boot.extraModulePackages = [ algRgbKernelModule ];
  boot.kernelModules = [ "alg_rgb" ];

  environment.systemPackages = [ algRgbCli ];
}

