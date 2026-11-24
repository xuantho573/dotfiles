{ ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "mermaid-cli"
    ];
    casks = [
      "font-sf-pro"
      "handbrake-app"
      "megasync"
      "slack"
      "zalo"
    ];
    onActivation.cleanup = "zap";
  };
}
