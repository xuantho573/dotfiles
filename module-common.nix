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
            "side-by-side" = true;
          };
          init = {
            defaultBranch = "main";
          };
        };
      }
    ];
  };

  home.packages = with pkgs; [
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

    colima
    docker
    lazydocker
    lazygit
    kitty
    fastfetch
    neovim
    starship
    vscode

    tree-sitter

    just

    mongodb-compass
    volta
    direnv
    nixd
    nixfmt-rfc-style

    clang-tools
    typescript
    vue-language-server
    vtsls
    eslint_d
    svelte-language-server

    tailwindcss-language-server
    vscode-langservers-extracted

    bash-language-server
    shellcheck-minimal
    shfmt

    lua-language-server
    stylua

    pyright

    rustup

    yaml-language-server

    firefox
    google-chrome
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
