{ pkgs, mkSymlink, ... }:

{
  home = {
    packages = with pkgs; [ fzf ];
    file = {
      ".local/bin/fzf-preview.sh".source = mkSymlink ./fzf-preview.sh;
      ".fzfrc".source = mkSymlink ./.fzfrc;
    };
  };
}
