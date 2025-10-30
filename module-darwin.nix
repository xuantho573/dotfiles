{
  pkgs,
  lib,
  mkSymlink,
  ...
}:

lib.mkIf pkgs.stdenv.isDarwin {
  home.packages = with pkgs; [
    unnaturalscrollwheels
    raycast
    pngpaste
    betterdisplay
    monitorcontrol
    ice-bar
    keycastr
    yabai
    sketchybar
    jankyborders
    switchaudio-osx
    blueutil
  ];

  xdg.configFile = {
    kanata.source = mkSymlink ./kanata;
    sketchybar.source = mkSymlink ./sketchybar;
    yabai.source = mkSymlink ./yabai;
  };
}
