{ inputs, config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

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
    stateVersion = "24.05"; # Please read the comment before changing.
    enableNixpkgsReleaseCheck = false;
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
      eza
    ];
  };

  programs = {
    home-manager.enable = true;
    /*
    wezterm = {
      enable = true;
      package = inputs.wezterm.packages.${pkgs.system}.default;
    };
    */
    zsh = {
      enable = true;
      localVariables = {
        NVM_DIR = "$HOME/.nvm";
      };
      initExtra = ''
        eval "$(starship init zsh)"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      '';
      shellAliases = {
        ls = "exa --icons";
        la = "exa --icons --all";
        lla = "exa --icons --long --all";
      };
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "db085e4661f6aafd24e5acb5b2e17e4dd5dddf3e";
            sha256 = "iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
          };
        }
      ];
    };
  };
}
