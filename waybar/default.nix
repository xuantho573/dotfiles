{ pkgs, makePath, ... }:

{
  xdg.configFile."waybar/config".source = makePath ./config;
  xdg.configFile."waybar/catppuccin-latte.css".source = makePath ./catppuccin-latte.css;
  xdg.configFile."waybar/style.css".source = makePath ./style.css;
}
