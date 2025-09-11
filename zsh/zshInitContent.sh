eval "$(direnv hook zsh)"
type starship_zle-keymap-select >/dev/null || eval "$(starship init zsh)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

ANTHROPIC_API_KEY=$(op read "op://Private/Anthropic/API key")
GEMINI_API_KEY=$(op read "op://Private/Google AI/API key")
GROQ_API_KEY=$(op read "op://Private/Groq/API key")

export ANTHROPIC_API_KEY
export GEMINI_API_KEY
export GROQ_API_KEY

# THEME
LIGHT_THEME=catppuccin-latte
DARK_THEME=catppuccin-macchiato
LIGHT_THEME_WITH_ACCENT=catppuccin-latte-sky
DARK_THEME_WITH_ACCENT=catppuccin-macchiato-sky

# Starship
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml

# Bat
export BAT_THEME="Catppuccin Latte"

# Lazygit
LG_DIR=$XDG_CONFIG_HOME/lazygit
export LG_CONFIG_FILE=$LG_DIR/config.yml,$LG_DIR/$LIGHT_THEME_WITH_ACCENT.yml

function change_background() {
  local theme
  local theme_with_accent

  if [[ "$1" == "light" ]]; then
    export BAT_THEME="Catppuccin Latte"
    theme=$LIGHT_THEME
    theme_with_accent=$LIGHT_THEME_WITH_ACCENT

    if [[ "$OSTYPE" == "darwin"* ]]; then
      osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false"
    else
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    fi
  elif [[ "$1" == "dark" ]]; then
    export BAT_THEME="Catppuccin Macchiato"
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

  dasel put -f "$STARSHIP_CONFIG" -v $theme palette
  export LG_CONFIG_FILE=$LG_DIR/config.yml,$LG_DIR/$theme_with_accent.yml
}

function y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd" || exit
  fi
  rm -f -- "$tmp"
}

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
