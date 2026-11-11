{
  pkgs,
  lib,
  pkgs-unstable,
  ...
}:

lib.mkIf pkgs.stdenv.isDarwin {
  home.packages = [
    pkgs-unstable.raycast
  ]
  ++ (with pkgs; [
    unnaturalscrollwheels
    pngpaste
    betterdisplay
    monitorcontrol
    keycastr
    jankyborders
    switchaudio-osx
    blueutil
    the-unarchiver
  ]);
}
