{ pkgs, makePath, ... }:

{
  xdg.configFile."wezterm/wezterm.lua".source = makePath ./wezterm.lua;
  # home.packages = [pkgs.tmux];
}
