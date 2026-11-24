{
  pkgs,
  lib,
  mkSymlink,
  ...
}:

lib.mkIf pkgs.stdenv.isLinux {
  home.packages = with pkgs; [
    alsa-utils
    networkmanagerapplet
    pavucontrol

    fcitx5
    hyprland
    hypridle
    rofi
    nixgl.auto.nixGLDefault
    waybar
    wlogout
  ];

  xdg.configFile = {
    fcitx5.source = mkSymlink ../apps/fcitx5;
    hypr.source = mkSymlink ../apps/hypr;
    rofi.source = mkSymlink ../apps/rofi;
    swaync.source = mkSymlink ../apps/swaync;
    waybar.source = mkSymlink ../apps/waybar;
    wlogout.source = mkSymlink ../apps/wlogout;
  };
}
