{ pkgs, ... }:

let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "btop";
    rev = "1.0.0";
    sha256 = "J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
  };
in
{
  programs.btop = {
    enable = true;
    themes = {
      catppuccin_latte = builtins.readFile (catppuccin + "/themes/catppuccin_latte.theme");
      catppuccin_macchiato = builtins.readFile (catppuccin + "/themes/catppuccin_macchiato.theme");
    };
  };
}
