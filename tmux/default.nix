{ pkgs, mkSymlink, ... }:

let
  catppuccinPluginSource = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "tmux";
    rev = "v2.1.2";
    sha256 = "vBYBvZrMGLpMU059a+Z4SEekWdQD0GrDqBQyqfkEHPg=";
  };

  lightThemeSource = pkgs.runCommand "catppuccin-light-theme.conf" { } ''
    sed 's/-ogq/-gq/g' ${catppuccinPluginSource}/themes/catppuccin_latte_tmux.conf > $out
    echo "run ~/.config/tmux/plugins/catppuccin/catppuccin.tmux" >> $out
  '';

  darkThemeSource = pkgs.runCommand "catppuccin-dark-theme.conf" { } ''
    sed 's/-ogq/-gq/g' ${catppuccinPluginSource}/themes/catppuccin_macchiato_tmux.conf > $out
    echo "run ~/.config/tmux/plugins/catppuccin/catppuccin.tmux" >> $out
  '';
in
{
  home.packages = with pkgs; [
    tmux
    tmuxifier
  ];

  xdg.configFile = {
    "tmux/tmux.conf".source = mkSymlink ./tmux.conf;
    "tmux/dark-theme.tmux.conf".source = darkThemeSource;
    "tmux/light-theme.tmux.conf".source = lightThemeSource;
    "tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "v3.1.0";
      sha256 = "CeI9Wq6tHqV68woE11lIY4cLoNY8XWyXyMHTDmFKJKI=";
    };
    "tmux/plugins/catppuccin".source = catppuccinPluginSource;
  };
}
