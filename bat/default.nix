{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    themes =
      let
        catppuccin = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "699f60fc8ec434574ca7451b444b880430319941";
          sha256 = "6fWoCH90IGumAMc4buLRWL0N61op+AuMNN9CAR9/OdI=";
        };
      in
      {
        catppuccin-latte = {
          src = catppuccin;
          file = "themes/Catppuccin Latte.tmTheme";
        };
        catppuccin-macchiato = {
          src = catppuccin;
          file = "themes/Catppuccin Macchiato.tmTheme";
        };
      };
  };
}
