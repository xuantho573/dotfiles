eval "$(starship init zsh)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

function change_background() {
  local LG_CONFIG_DIR=$HOME/.config/lazygit
  if [[ "$1" == "light" ]]; then
    export LG_CONFIG_FILE=$LG_CONFIG_DIR/config.yml,$LG_CONFIG_DIR/catppuccin-latte-sky.yml
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  elif [[ "$1" == "dark" ]]; then
    export LG_CONFIG_FILE=$LG_CONFIG_DIR/config.yml,$LG_CONFIG_DIR/catppuccin-macchiato-sky.yml
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  fi
}

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
