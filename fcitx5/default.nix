{ pkgs, makePath, ... }:

{
  xdg.configFile."fcitx5/conf" = {
    source = makePath ./conf;
    recursive = true;
  };
  xdg.configFile."fcitx5/config".source = makePath ./config;
  xdg.configFile."fcitx5/profile".source = makePath ./profile;
}
