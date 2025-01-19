{ pkgs, makePath, isDarwin, lib, ... }:

{
  home.packages = lib.mkIf (!isDarwin) [pkgs.hypridle];
  xdg.configFile."hypr/themes" = {
    source = makePath ./themes;
    recursive = true;
  };
  xdg.configFile."hypr/hypridle.conf".source = makePath ./hypridle.conf;
  xdg.configFile."hypr/hyprland.conf".source = makePath ./hyprland.conf;
  xdg.configFile."hypr/hyprlock.conf".source = makePath ./hyprlock.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = makePath ./hyprpaper.conf;
}
