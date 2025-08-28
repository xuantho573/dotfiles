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
    hypridle
    rofi-wayland
    waybar
    wlogout
  ];

  xdg.configFile = {
    fcitx5.source = mkSymlink ./fcitx5;
    hypr.source = mkSymlink ./hypr;
    rofi.source = mkSymlink ./rofi;
    swaync.source = mkSymlink ./swaync;
    waybar.source = mkSymlink ./waybar;
    wlogout.source = mkSymlink ./wlogout;
  };
}
