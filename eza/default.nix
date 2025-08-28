{ pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
  ];

  xdg.configFile."eza/theme.yml" = {
    source =
      let
        catppuccin = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "eza";
          rev = "f3e093f8aba954d0c7eb1fc51d9b04e9ce0159ff";
          sha256 = "R9t6innhXZOQKToKGl4BceQOa5au9ANf8SXm4+Dgg5I=";
        };
      in
      catppuccin + "/themes/latte/catppuccin-latte-sky.yml";
  };
}
