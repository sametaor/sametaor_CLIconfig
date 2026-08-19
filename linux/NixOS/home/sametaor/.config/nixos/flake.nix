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
    ani2hyprtui.url = "github:Sevilze/ani2hyprtui";
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
            ./hardware-configuration.nix
            ./configuration.nix
            ./alg-rgb.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.sametaor = import ./home.nix;
                backupFileExtension = "bak";
                home-manager.overwriteBackup = true;
              };
            }
          ];
        };
      };
    };
}
