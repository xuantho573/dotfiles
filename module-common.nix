{
  pkgs,
  mkSymlink,
  ...
}:

{
  imports = [
    ./bat
    ./btop
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
    lazydocker.source = mkSymlink ./lazydocker;
    lazygit.source = mkSymlink ./lazygit;
    kitty.source = mkSymlink ./kitty;
    fastfetch.source = mkSymlink ./fastfetch;
    nvim.source = mkSymlink ./neovim;
    starship.source = mkSymlink ./starship;
    wezterm.source = mkSymlink ./wezterm;
  };
}
