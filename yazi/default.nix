{ pkgs, mkSymlink, ... }:

{
  programs.yazi = {
    enable = true;
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
      rev = "0f9204bc948c8313963f5c9d571a82edc201f8aa"; # May 31, 2026
      sha256 = "qWNArjWuxWL+rOjLzyIniW5hJgWiAWTCgXmMXJpaWZE=";
    };
    "yazi/init.lua".source = mkSymlink ./init.lua;
    "yazi/yazi.toml".source = mkSymlink ./yazi.toml;
  };
}
