{ pkgs, ... }:

let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "btop";
    rev = "1.0.0";
    sha256 = "J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
  };
in {
  home.packages = [pkgs.btop];

  xdg.configFile."btop/themes/catppuccin_latte.theme".source = catppuccin + "/themes/catppuccin_latte.theme";
  xdg.configFile."btop/themes/catppuccin_macchiato.theme".source = catppuccin + "/themes/catppuccin_macchiato.theme";
}
