{ pkgs, makePath, ... }:

{
  xdg.configFile."neofetch/config.conf".source = makePath ./config.conf;
  home.packages = [pkgs.neofetch];
}
