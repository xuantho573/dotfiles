{ pkgs, lib, mkConfigFileSymlink, importSubModule, ... }:

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
    lazydocker = mkConfigFileSymlink ./lazydocker true;
    lazygit = mkConfigFileSymlink ./lazygit true;
    kitty = mkConfigFileSymlink ./kitty true;
    neofetch = mkConfigFileSymlink ./neofetch true;
    nvim = mkConfigFileSymlink ./neovim true;
    "starship.toml" = mkConfigFileSymlink ./starship/starship.toml false;
    wezterm = mkConfigFileSymlink ./wezterm true;
    yazi = mkConfigFileSymlink ./yazi true;
  };
}
