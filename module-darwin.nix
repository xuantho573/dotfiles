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
    jankyborders
  ];

  xdg.configFile = {
    kanata.source = mkSymlink ./kanata;
    yabai.source = mkSymlink ./yabai;
  };
}
