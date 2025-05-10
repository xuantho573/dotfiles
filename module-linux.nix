{
  pkgs,
  lib,
  isDarwin,
  mkConfigDirSymlink,
  ...
}:

lib.mkIf (!isDarwin) {
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
    fcitx5 = mkConfigDirSymlink ./fcitx5;
    hypr = mkConfigDirSymlink ./hypr;
    rofi = mkConfigDirSymlink ./rofi;
    swaync = mkConfigDirSymlink ./swaync;
    waybar = mkConfigDirSymlink ./waybar;
    wlogout = mkConfigDirSymlink ./wlogout;
  };
}
