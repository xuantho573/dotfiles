eval "$(starship init zsh)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# THEME
local LIGHT_THEME=catppuccin-latte
local DARK_THEME=catppuccin-macchiato
local LIGHT_THEME_WITH_ACCENT=catppuccin-latte-sky
local DARK_THEME_WITH_ACCENT=catppuccin-macchiato-sky

# Starship
export STARSHIP_CONFIG_FILE=$XDG_CONFIG_HOME/starship/starship.toml

# Bat
export BAT_THEME=$LIGHT_THEME

# Lazygit
local LG_DIR=$XDG_CONFIG_HOME/lazygit
export LG_CONFIG_FILE=$LG_DIR/config.yml,$LG_DIR/$LIGHT_THEME_WITH_ACCENT.yml

function change_background() {
  local theme
  local theme_with_accent

  if [[ "$1" == "light" ]]; then
    theme=$LIGHT_THEME
    theme_with_accent=$LIGHT_THEME_WITH_ACCENT

    if [[ "$OSTYPE" == "darwin"* ]]; then
      osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false"
    else
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    fi
  elif [[ "$1" == "dark" ]]; then
    theme=$DARK_THEME
    theme_with_accent=$DARK_THEME_WITH_ACCENT

    if [[ "$OSTYPE" == "darwin"* ]]; then
      osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true"
    else
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    fi
  else
    echo "Please provide 'light' or 'dark'."
    return
  fi

  dasel put -f $STARSHIP_CONFIG_FILE -v $theme palette
  export BAT_THEME=$theme
  export LG_CONFIG_FILE=$LG_DIR/config.yml,$LG_DIR/$theme_with_accent.yml
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
