{ config, pkgs, lib, username, homeDirectory, homeManagerDir, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  removePrefix = dir: subDir: builtins.substring
    (builtins.stringLength (toString dir))
    (-1)
    (toString subDir)
  ;
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink (homeManagerDir + (removePrefix ./. path));
  mkConfigFileSymlink = path: {
    source = mkSymlink path;
  };
  mkConfigDirSymlink = path: {
    source = mkSymlink path;
    recursive = true;
  };
  importSubModule = path: import path { inherit pkgs lib homeManagerDir mkSymlink; };
  importModule = path: import path { inherit pkgs lib isDarwin mkConfigFileSymlink mkConfigDirSymlink importSubModule; };
in {
  imports = [
    (importModule ./module-common.nix)
    (importModule ./module-linux.nix)
    (importModule ./module-darwin.nix)
  ];

  xdg.enable = true;
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home = {
    # Home Manager needs a bit of information about you and the paths it should manage.
    inherit username homeDirectory;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.
    enableNixpkgsReleaseCheck = true;
  };
}
