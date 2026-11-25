{ ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "mermaid-cli"
    ];
    casks = [
      "claude-code"
      "font-sf-pro"
      "handbrake-app"
      "megasync"
      "slack"
      "zalo"
    ];
    onActivation.cleanup = "zap";
  };
}
