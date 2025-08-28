{ pkgs, flakeDir, ... }:

{
  programs.zsh = {
    enable = true;
    localVariables = {
      NVM_DIR = "$HOME/.nvm";
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
    };
    sessionVariables = {
      NIX_PROFILE = "$HOME/.nix-profile";
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
    history.append = true;
    initContent = ''${builtins.readFile ./zshInitContent.sh}'';
    shellAliases = {
      ff = "fastfetch";
      ls = "exa --icons";
      la = "exa --icons --all";
      lla = "exa --icons --long --all";
      lazygit = "LG_CONFIG_FILE=$LG_CONFIG_FILE lazygit";
      hms = "home-manager switch --flake ${flakeDir} --impure";
    };
    plugins = with pkgs; [
      {
        name = "zsh-vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-history-substring-search";
        src = zsh-history-substring-search;
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
      }
      {
        name = "zsh-sudo";
        src = fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "a6beb0f5958e935d33b0edb6d4470c3d7c4e8917";
          sha256 = "5Smg7KBCl+I1Uf10aE6NvYibxXUwRMdrxr49rLtvSE0=";
        };
        file = "plugins/sudo/sudo.plugin.zsh";
      }
    ];
  };
}
