{ pkgs, makePath, ... }:

{
  xdg.configFile = {
    "nvim/init.lua".source = makePath ./init.lua;
    "nvim/lazy-lock.json".source = makePath ./lazy-lock.json;
    "nvim/lazyvim.json".source = makePath ./lazyvim.json;
    "nvim/lua" = {
      source = makePath ./lua;
      recursive = true;
    };
  };
  home.packages = [pkgs.neovim];
}
