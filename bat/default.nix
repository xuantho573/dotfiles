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
        "Catppuccin Latte" = {
          src = catppuccin;
          file = "themes/Catppuccin Latte.tmTheme";
        };
        "Catppuccin Frappe" = {
          src = catppuccin;
          file = "themes/Catppuccin Frappe.tmTheme";
        };
        "Catppuccin Macchiato" = {
          src = catppuccin;
          file = "themes/Catppuccin Macchiato.tmTheme";
        };
        "Catppuccin Mocha" = {
          src = catppuccin;
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
  };
}
