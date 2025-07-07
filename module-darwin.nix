{
  pkgs,
  lib,
  isDarwin,
  ...
}:

lib.mkIf isDarwin {
  home.packages = with pkgs; [
    unnaturalscrollwheels
    raycast
    pngpaste
    betterdisplay
  ];
}
