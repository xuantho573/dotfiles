{ pkgs, makePath, ... }:

{
  xdg.configFile."swaync/style.css".source = makePath ./style.css;
}
