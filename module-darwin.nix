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
    keycastr
    jankyborders
    switchaudio-osx
    blueutil
    the-unarchiver
  ];

  xdg.configFile = {
    kanata.source = mkSymlink ./kanata;
  };
}
