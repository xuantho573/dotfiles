{ pkgs, ... }:

{
  home.packages = with pkgs; [
    spicetify-cli
  ];

  xdg.configFile."spicetify/Themes/catppuccin" = {
    source =
      let
        catppuccin = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "spicetify";
          rev = "4294a61f54a044768c6e9db20e83c5b74da71091";
          sha256 = "OHsauoCjj99aoIbq78xQf1ehYtLpIcUde5DmZSJFCXI=";
        };
      in
      catppuccin + "/catppuccin";
  };
}
