{ pkgs, makePath, ... }:

{
  xdg.configFile."kitty/kitty.conf".source = makePath ./kitty.conf;
  xdg.configFile."kitty/nerd-font-symbols.conf".source = makePath ./nerd-font-symbols.conf;
  xdg.configFile."kitty/light-theme.auto.conf".source = makePath ./themes/light-theme.auto.conf;
  xdg.configFile."kitty/dark-theme.auto.conf".source = makePath ./themes/dark-theme.auto.conf;
  home.packages = [pkgs.kitty];
}
