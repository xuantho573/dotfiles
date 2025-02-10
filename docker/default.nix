{ pkgs, makePath, ... }:

{
  xdg.configFile."lazydocker/config.yml".source = makePath ./lazydockerConfig.yml;

  home.packages = with pkgs; [
    colima
    docker
    lazydocker
  ];
}
