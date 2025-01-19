{ pkgs, makePath, ... }:

{
  home.packages = with pkgs; [
    tmux
    tmuxifier
  ];

  xdg.configFile."tmux/tmux.conf".source = makePath ./tmux.conf;

  xdg.configFile."tmux/plugins/tpm" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "v3.1.0";
      sha256 = "CeI9Wq6tHqV68woE11lIY4cLoNY8XWyXyMHTDmFKJKI=";
    };
  };

  xdg.configFile."tmux/plugins/catppuccin" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "v2.1.2";
      sha256 = "vBYBvZrMGLpMU059a+Z4SEekWdQD0GrDqBQyqfkEHPg=";
    };
  };
}
