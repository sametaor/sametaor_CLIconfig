{
  description = "NixOS Flake.nix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alg-cli = {
      url = "github:24kaushik/alg-cli";
      flake = false;
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord.url = "github:4evy/nixcord";
    blender-bin.url = "github:edolstra/nix-warez?dir=blender";
    niri.url = "github:YaLTeR/niri";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    prismnix = {
      url = "github:qacow37/prismnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix = {
      url = "github:musnix/musnix";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eza = {
      url = "github:eza-community/eza";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bedrock-on-linux = {
      url = "github:Wyze3306/BedrockOnLinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    steam-config-nix = {
      url = "github:different-name/steam-config-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      alg-cli,
      zen-browser,
      nvf,
      nur,
      bedrock-on-linux,
      sops-nix,
      nix-index-database,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        nixsametaor = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            nur.modules.nixos.default
            nvf.nixosModules.default
            inputs.musnix.nixosModules.musnix
            sops-nix.nixosModules.sops
            ./hardware-configuration.nix
            ./configuration.nix
            ./alg-rgb.nix
            nix-index-database.nixosModules.nix-index
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.sametaor = {
                  imports = [
                    ./home.nix
                  ];
                };
                backupFileExtension = "bak";
                overwriteBackup = true;
              };
            }
          ];
        };
      };
      homeConfigurations."sametaor@nixsametaor" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = import ./overlays.nix { inherit inputs; };
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "electron-39.8.10"
              "electron-40.10.5"
              "ventoy-1.1.18"
            ];
          };
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home.nix ];
      };
    };
}
