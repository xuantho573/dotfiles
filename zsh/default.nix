{ pkgs, homeManagerDir, ... }:

{
  programs.zsh = {
    enable = true;
    localVariables = {
      NVM_DIR = "$HOME/.nvm";
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
    sessionVariables = {
      NIX_PROFILE = "$HOME/.nix-profile";
    };
    history.append = true;
    initExtra = ''${builtins.readFile ./zshInitExtra.sh} '';
    shellAliases = {
      ff = "fastfetch";
      ls = "exa --icons";
      la = "exa --icons --all";
      lla = "exa --icons --long --all";
      lazygit = "LG_CONFIG_FILE=$LG_CONFIG_FILE lazygit";
      hms = "home-manager switch --flake ${homeManagerDir} --impure";
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
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "87ce96b1862928d84b1afe7c173316614b30e301";
          sha256 = "1+w0AeVJtu1EK5iNVwk3loenFuIyVlQmlw8TWliHZGI=";
        };
      }
      {
        name = "zsh-sudo";
        src = pkgs.fetchFromGitHub {
          owner = "hcgraf";
          repo = "zsh-sudo";
          rev = "d8084def6bb1bde2482e7aa636743f40c69d9b32";
          sha256 = "I17u8qmYttsodD58PqtTxtVZauyYcNw1orFLPngo9bY=";
        };
      }
    ];
  };
}
