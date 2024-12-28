{ inputs, config, pkgs, lib, ... }:

{
  fonts.fontconfig.enable = true;
  imports = [
    ./home/zsh
  ];

  home = {
    # Home Manager needs a bit of information about you and the paths it should manage.
    username = "xuantho573";
    homeDirectory = "/home/xuantho573";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.
    enableNixpkgsReleaseCheck = true;
    packages = with pkgs; [
      # fonts
      (nerdfonts.override { fonts = ["FiraCode" "JetBrainsMono"]; })
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      neofetch
      diff-so-fancy
      tldr
      neovim
      bat
      btop
      ripgrep
      neovim
      lazygit
      fzf
      yazi
      starship
      gcc14
      alsa-utils
      rofi-wayland
      postgresql
      pgadmin4
      lazydocker
      less
      spicetify-cli
      fd
      eza
      jq
      tmux
      tmuxifier
      bun
      cargo
      wlogout
      hypridle
      pavucontrol
      networkmanagerapplet
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}
