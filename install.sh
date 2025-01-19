#!/bin/bash

if ! (command -v nix 2>&1 >/dev/null); then
  echo "Nix not found, installing nix"
  curl --progress-bar -L https://nixos.org/nix/install | sh -s -- --daemon
  # Restart the shell to use nix
  exec $SHELL
fi

echo "Copying configuration files with GNU Stow"
stow . -t "$HOME"

if command -v home-manager 2>&1 >/dev/null; then
  echo "Updating system configuration with home-manager"
  home-manager switch
else
  echo "Initialize home-manager and install system configuration"
  nix run home-manager/release-24.11 -- init --switch
fi

if ! (grep -F "zsh" /etc/shells) && (command -v zsh 2>&1 >/dev/null); then
  echo "Setting ZSH as the default shell"
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  chsh --shell "$(which zsh)"
fi

if ! (command -v wezterm 2>&1 >/dev/null); then
  echo "WezTerm terminal not set up, installing WezTerm"
  mkdir wezterm
  (
    cd wezterm || return
    curl -s -L https://github.com/wez/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage -o wezterm
    chmod +x wezterm
    curl -s -L https://camo.githubusercontent.com/1f4c93acde6585f17ccebb3b78280880e7533610235a499e8437d40531567e0b/68747470733a2f2f73637265656e73686f742e706963732f732f57657a5465726d5f49636f6e2e706e67 -o logo.png
  )
  sudo rm -rf /opt/wezterm
  sudo cp -r wezterm /opt/wezterm
  sudo rm -rf wezterm
  sudo ln -sf /opt/wezterm/wezterm /usr/local/bin/wezterm
fi
