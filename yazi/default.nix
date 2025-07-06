{ pkgs, mkSymlink, ... }:

{
  programs.yazi = {
    enable = true;
    initLua = ./init.lua;
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
    };
    theme.flavor = {
      dark = "catppuccin-frappe";
      light = "catppuccin-latte";
    };
  };
  xdg.configFile = {
    "yazi/flavors".source = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "flavors";
      rev = "d04a298a8d4ada755816cb1a8cfb74dd46ef7124";
      sha256 = "m3yk6OcJ9vbCwtxkMRVUDhMMTOwaBFlqWDxGqX2Kyvc=";
    };
    "yazi/package.toml".source = mkSymlink ./package.toml;
    "yazi/yazi.toml".source = mkSymlink ./yazi.toml;
  };
}
