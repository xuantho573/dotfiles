{
  pkgs,
  mkSymlink,
  ...
}:

{
  imports = [
    ./bat
    ./btop
    ./delta
    ./eza
    ./font
    ./fzf
    ./spicetify
    ./tmux
    ./yazi
    ./zsh
  ];

  programs.zathura = {
    enable = true;
    options = {
      useMupdf = false;
      "selection-clipboard" = "clipboard";
    };
  };

  programs.git = {
    enable = true;
    includes = [
      { path = "~/delta.catppuccin.gitconfig"; }
      {
        contents = {
          core = {
            pager = "delta";
          };
          delta = {
            features = "catppuccin-latte";
            "side-by-side" = true;
          };
        };
      }
    ];
  };

  home.packages = with pkgs; [
    discord
    obsidian
    spotify
    _1password-cli

    diff-so-fancy
    tldr
    ripgrep
    gcc14
    postgresql
    pgadmin4
    less
    fd
    jq
    dasel
    musescore
    syncthing
    cargo

    colima
    docker
    lazydocker
    lazygit
    kitty
    fastfetch
    neovim
    starship

    slack

    mongodb-compass
    volta
    direnv
    nixd
    nixfmt-rfc-style

    typescript
    vue-language-server
    vtsls
    eslint_d

    tailwindcss-language-server
    vscode-langservers-extracted

    bash-language-server
    shellcheck-minimal
    shfmt

    lua-language-server
    stylua
  ];

  xdg.configFile = {
    lazydocker.source = mkSymlink ./lazydocker;
    lazygit.source = mkSymlink ./lazygit;
    kitty.source = mkSymlink ./kitty;
    fastfetch.source = mkSymlink ./fastfetch;
    nvim.source = mkSymlink ./neovim;
    starship.source = mkSymlink ./starship;
    wezterm.source = mkSymlink ./wezterm;
  };
}
