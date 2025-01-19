{ pkgs, makePath, lib, ... }:

{
  xdg.configFile."lazygit" = {
    source = makePath ./lazygit;
    recursive = true;
  };
  home.packages = with pkgs; [
    lazygit
  ];
}
