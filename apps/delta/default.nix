{ pkgs, ... }:

let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "delta";
    rev = "7b06b1f174c03f53ff68da1ae1666ca3ef7683ad";
    hash = "sha256-HHD0hszHIxf/tyQgS5KtdAN5m0EM9oI54cA2Ij1keOI=";
  };
in
{
  home = {
    packages = with pkgs; [ delta ];
    file = {
      "delta.catppuccin.gitconfig".source = catppuccin + "/catppuccin.gitconfig";
    };
  };
}
