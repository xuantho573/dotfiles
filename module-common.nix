{
  pkgs,
  mkConfigDirSymlink,
  importSubModule,
  ...
}:

{
  imports = [
    (importSubModule ./bat)
    (importSubModule ./btop)
    (importSubModule ./font)
    (importSubModule ./tmux)
    (importSubModule ./yazi)
    (importSubModule ./zsh)
    (importSubModule ./spicetify)
  ];

  programs.zathura = {
    enable = true;
    options = {
      useMupdf = false;
      "selection-clipboard" = "clipboard";
    };
  };

  home.packages = with pkgs; [
    discord
    obsidian
    spotify
    _1password-cli

    diff-so-fancy
    tldr
    ripgrep
    fzf
    gcc14
    postgresql
    pgadmin4
    less
    fd
    eza
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

    nodejs_22
    yarn
    direnv
    nixd
    nixfmt-rfc-style

    typescript
    typescript-language-server
    vue-language-server
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
    lazydocker = mkConfigDirSymlink ./lazydocker;
    lazygit = mkConfigDirSymlink ./lazygit;
    kitty = mkConfigDirSymlink ./kitty;
    fastfetch = mkConfigDirSymlink ./fastfetch;
    nvim = mkConfigDirSymlink ./neovim;
    starship = mkConfigDirSymlink ./starship;
    wezterm = mkConfigDirSymlink ./wezterm;
  };
}
