{
  pkgs,
  mkSymlink,
  ...
}:

{
  imports = [
    ../apps/bat
    ../apps/btop
    ../apps/delta
    ../apps/eza
    ../apps/font
    ../apps/fzf
    ../apps/spicetify
    ../apps/tmux
    ../apps/yazi
    ../apps/zsh
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
          pull = {
            rebase = true;
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
    gh

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
    lazydocker.source = mkSymlink ../apps/lazydocker;
    lazygit.source = mkSymlink ../apps/lazygit;
    kitty.source = mkSymlink ../apps/kitty;
    fastfetch.source = mkSymlink ../apps/fastfetch;
    nvim.source = mkSymlink ../apps/neovim;
    starship.source = mkSymlink ../apps/starship;
    wezterm.source = mkSymlink ../apps/wezterm;
  };
}
