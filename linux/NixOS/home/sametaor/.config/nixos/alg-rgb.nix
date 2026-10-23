{ config, pkgs, lib, ... }:

let
  algRgbSrc = pkgs.fetchFromGitHub {
    owner = "24kaushik";
    repo = "alg-cli";
    rev = "main";
    hash = "sha256-kJGyCZMhBVAP0RTvCyQKz0pzgGa2itNvoqNJikwzxVo=";
  };

  algRgbKernelModule = config.boot.kernelPackages.callPackage
    ({ lib, stdenv, kernel }:
      stdenv.mkDerivation {
        pname = "alg-rgb-kernel-module";
        version = "latest";

        src = algRgbSrc;

        nativeBuildInputs = kernel.moduleBuildDependencies;

        buildPhase = ''
          runHook preBuild
          make -C "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" \
            M="$PWD/kernel" \
            modules
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p "$out/lib/modules/${kernel.modDirVersion}/extra"
          cp "$PWD/kernel/alg_rgb.ko" \
            "$out/lib/modules/${kernel.modDirVersion}/extra/alg_rgb.ko"
          touch "$out/lib/modules/${kernel.modDirVersion}/extra/alg_rgb.ko.cer"
          
          runHook postInstall
        '';

        meta = with lib; {
          description = "Native Linux RGB keyboard control kernel module for Acer ALG laptops";
          homepage = "https://github.com/24kaushik/alg-cli";
          license = licenses.gpl2Only;
          platforms = platforms.linux;
        };
      })
    { };

  # Added: Compiling the companion userspace CLI utility
  algRgbCli = pkgs.stdenv.mkDerivation {
    pname = "alg-rgb-cli";
    version = "latest";

    src = algRgbSrc;

    buildPhase = ''
      runHook preBuild
      cd cli
      make
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      cp alg-rgb $out/bin/
      runHook postInstall
    '';

    meta = with lib; {
      description = "CLI utility to control the Acer ALG laptop RGB keyboard";
      homepage = "https://github.com/24kaushik/alg-cli";
      license = licenses.gpl2Only;
      platforms = platforms.linux;
    };
  };

in {
  # Load the kernel module
  boot.extraModulePackages = [ algRgbKernelModule ];
  boot.kernelModules = [ "alg_rgb" ];

  # Install the CLI tool to the system profile
  environment.systemPackages = [ algRgbCli ];

  # Added: Allow users in the wheel (admin) group to change keyboard colours without sudo
  services.udev.extraRules = ''
    KERNEL=="alg_rgb", GROUP="wheel", MODE="0660"
  '';
}
