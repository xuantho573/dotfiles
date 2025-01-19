{ pkgs, makePath, lib, isDarwin, ... }:

{
  home.file."Library/Application Support/jesseduffield/lazydocker/config.yml".source = lib.mkIf
    isDarwin
    (makePath ./lazydockerConfig.yml);

  xdg.configFile."lazydocker/config.yml".source = makePath ./lazydockerConfig.yml;

  home.packages = with pkgs; [
    colima
    docker
    lazydocker
  ];
}
