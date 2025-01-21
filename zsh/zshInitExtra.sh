eval "$(starship init zsh)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

function change_background() {
  local LG_DIR=$XDG_CONFIG_HOME/lazygit
  if [[ "$1" == "light" ]]; then
    # Bat theme
    export BAT_THEME=catppuccin-latte

    # Lazygit
    export LG_CONFIG_FILE=$LG_DIR/config.yml,$LG_DIR/catppuccin-latte-sky.yml

    # System
    if [[ "$OSTYPE" == "darwin"* ]]; then
      osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false"
    else
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    fi
  elif [[ "$1" == "dark" ]]; then
    # Bat theme
    export BAT_THEME=catppuccin-macchiato

    # Lazygit
    export LG_CONFIG_FILE=$LG_DIR/config.yml,$LG_DIR/catppuccin-macchiato-sky.yml

    # System
    if [[ "$OSTYPE" == "darwin"* ]]; then
      osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true"
    else
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    fi
  else
    echo "Please provide 'light' or 'dark'."
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
