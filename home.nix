{ config, pkgs, username, homeDirectory, homeManagerDir, lib, ... }:

let
  removePrefix = dir: subDir: builtins.substring
    (builtins.stringLength (toString dir))
    (-1)
    (toString subDir)
  ;
  customImport = path: import path {
    inherit pkgs;
    inherit homeManagerDir;
    inherit lib;
    isDarwin = pkgs.lib.strings.hasSuffix "darwin" builtins.currentSystem;
    makePath = subPath: config.lib.file.mkOutOfStoreSymlink (homeManagerDir + (removePrefix ./. subPath));
  };
  unfreePackages = with pkgs; [
    obsidian
    spotify
    discord
  ];
in {
  imports = [
    (customImport ./bat)
    (customImport ./btop)
    (customImport ./docker)
    (customImport ./fcitx5)
    (customImport ./font)
    (customImport ./git)
    (customImport ./hypr)
    (customImport ./kitty)
    (customImport ./neofetch)
    (customImport ./neovim)
    (customImport ./rofi)
    (customImport ./starship)
    (customImport ./swaync)
    (customImport ./tmux)
    (customImport ./waybar)
    (customImport ./wezterm)
    (customImport ./wlogout)
    (customImport ./yazi)
    (customImport ./zsh)
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem
      (lib.getName pkg)
      (map lib.getName unfreePackages);

  home = {
    # Home Manager needs a bit of information about you and the paths it should manage.
    inherit username;
    inherit homeDirectory;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.
    enableNixpkgsReleaseCheck = true;
    packages = unfreePackages ++ (with pkgs; [
      diff-so-fancy
      tldr
      ripgrep
      fzf
      gcc14
      # alsa-utils
      postgresql
      pgadmin4
      less
      spicetify-cli
      fd
      eza
      jq
      dasel
      unnaturalscrollwheels
      musescore
      syncthing
      # pavucontrol
      # networkmanagerapplet
    ]);
  };

  programs.home-manager.enable = true;
  xdg.enable = true;
}
