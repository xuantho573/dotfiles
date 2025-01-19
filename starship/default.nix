{ pkgs, makePath, ... }:

{
  xdg.configFile."starship.toml".source = makePath ./starship.toml;
  home.packages = [pkgs.starship];
}
