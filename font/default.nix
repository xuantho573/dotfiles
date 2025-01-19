{ pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Fira Code"
        "JetBrains Mono"
      ];
    };
  };

  home = {
    packages = with pkgs; [
      fira-code
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };
}
