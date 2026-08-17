
{
  nix = {
    settings = {
      substituters = [
        "https://huggingface.cachix.org"
      ];
      trusted-public-keys = [
        "huggingface.cachix.org-1:ynTPbLS0W8ofXd9fDjk1KvoFky9K2jhxe6r4nXAkc/o="
      ];
    };
  };
}
