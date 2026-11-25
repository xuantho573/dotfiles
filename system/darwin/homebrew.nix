{ ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "mermaid-cli"
    ];
    casks = [
      "antigravity-cli"
      "claude-code"
      "font-sf-pro"
      "handbrake-app"
      "megasync"
      "slack"
      "vorssaint"
      "zalo"
    ];
    onActivation.cleanup = "zap";
  };
}
