{ pkgs, makePath, lib, isDarwin, ... }:

{
  home.packages = lib.mkIf (!isDarwin) [pkgs.wlogout];

  xdg.configFile."wlogout/icons" = {
    source = makePath ./icons;
    recursive = true;
  };
  xdg.configFile."wlogout/layout".source = makePath ./layout;
  xdg.configFile."wlogout/style.css".source = makePath ./style.css;
}
