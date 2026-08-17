
{
  nix = {
    settings = {
      substituters = [
        "https://nixpkgs-unfree-redistributable.cachix.org"
      ];
      trusted-public-keys = [
        "nixpkgs-unfree-redistributable.cachix.org-1:3NlrGoiNuFaStmiTHLAZwtAPFPe7FukMEY+TMMF6YQk="
      ];
    };
  };
}
