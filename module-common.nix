{ pkgs, lib, mkConfigDirSymlink, importSubModule, ... }:

{
  imports = [
    (importSubModule ./bat)
    (importSubModule ./btop)
    (importSubModule ./font)
    (importSubModule ./tmux)
    (importSubModule ./zsh)
  ];

  home.packages = with pkgs; [
    discord
    obsidian
    spotify

    diff-so-fancy
    tldr
    ripgrep
    fzf
    gcc14
    postgresql
    pgadmin4
    less
    spicetify-cli
    fd
    eza
    jq
    dasel
    musescore
    syncthing

    colima
    docker
    lazydocker
    lazygit
    kitty
    neofetch
    neovim
    starship
    yazi
  ];

  xdg.configFile = {
    lazydocker = mkConfigDirSymlink ./lazydocker;
    lazygit = mkConfigDirSymlink ./lazygit;
    kitty = mkConfigDirSymlink ./kitty;
    neofetch = mkConfigDirSymlink ./neofetch;
    nvim = mkConfigDirSymlink ./neovim;
    starship = mkConfigDirSymlink ./starship;
    wezterm = mkConfigDirSymlink ./wezterm;
    yazi = mkConfigDirSymlink ./yazi;
  };
}
