{ pkgs, makePath, lib, isDarwin, ... }:

{
  home.packages = lib.mkIf (!isDarwin) [pkgs.rofi-wayland];

  xdg.configFile."rofi/themes" = {
    source = makePath ./themes;
    recursive = true;
  };
  xdg.configFile."rofi/config.rasi".source = makePath ./config.rasi;
}
