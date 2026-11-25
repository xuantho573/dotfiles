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
      "zalo"
    ];
    onActivation.cleanup = "zap";
  };
}
