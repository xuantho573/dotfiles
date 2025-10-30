{ pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "JetBrains Mono NL"
        "JetBrains Mono"
        "Fira Code"
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
      nerd-fonts.jetbrains-mono
    ];
  };
}
