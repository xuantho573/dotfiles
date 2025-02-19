{ pkgs, lib, isDarwin, mkConfigFileSymlink, ... }:

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

  xdg.configFile =  {
    fcitx5 = mkConfigFileSymlink ./fcitx5 true;
    hypr = mkConfigFileSymlink ./hypr true;
    rofi = mkConfigFileSymlink ./rofi true;
    swaync = mkConfigFileSymlink ./swaync true;
    waybar = mkConfigFileSymlink ./waybar true;
    wlogout = mkConfigFileSymlink ./wlogout true;
  };
}
