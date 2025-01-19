{ pkgs, makePath, ... }:

{
  home.packages = [pkgs.yazi];

  xdg.configFile."yazi/plugins" = {
    source = makePath ./plugins;
    recursive = true;
  };
  xdg.configFile."yazi/init.lua".source = makePath ./init.lua;
  xdg.configFile."yazi/package.toml".source = makePath ./package.toml;
  xdg.configFile."yazi/theme.toml".source = makePath ./theme.toml;
}
