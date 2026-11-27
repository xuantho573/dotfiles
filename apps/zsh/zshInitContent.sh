zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always $realpath'
eval "$(fzf --zsh)"
eval "$(direnv hook zsh)"
type starship_zle-keymap-select >/dev/null || eval "$(starship init zsh)"

export FZF_DEFAULT_OPTS_FILE=~/.fzfrc

# THEME
LIGHT_THEME=catppuccin-latte
DARK_THEME=catppuccin-macchiato
LIGHT_THEME_WITH_ACCENT=catppuccin-latte-sky
DARK_THEME_WITH_ACCENT=catppuccin-macchiato-sky

# Lazygit
LG_DIR=$XDG_CONFIG_HOME/lazygit
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

  local tmp_starship
  tmp_starship="$(mktemp)"
  if dasel -i toml --root "palette = \"$theme\"" <"$STARSHIP_CONFIG" >"$tmp_starship"; then
    command cat -- "$tmp_starship" >"$STARSHIP_CONFIG"
  fi
  rm -f -- "$tmp_starship"
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

function dotfiles() {
  local state_file="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles-flake-dir"
  local dir=""
  if [[ -f "$state_file" ]]; then
    dir="$(<"$state_file")"
  elif [[ -n "${NH_FLAKE:-}" ]]; then
    dir="$NH_FLAKE"
  fi

  local cmd="${1:-help}"
  case "$cmd" in
  help | -h | --help)
    cat <<'EOF'
Usage: dotfiles <command>

Commands:
  init           Save clone path and run the initial system/home switch
  switch         Switch the full configuration for the current OS
  switch-system  Switch system layer (nix-darwin on macOS, system-manager on Arch Linux)
  switch-home    Switch standalone Home Manager (Arch Linux)
  update         Update flake inputs
  check          Run pure flake checks
EOF
    return 0
    ;;
  esac

  if [[ -z "$dir" || ! -d "$dir" ]]; then
    echo "dotfiles: could not locate dotfiles repo (checked $state_file and \$NH_FLAKE)" >&2
    return 1
  fi

  case "$cmd" in
  init)
    "$dir/init.sh"
    ;;
  switch)
    case "$(uname -s)" in
    Darwin)
      dotfiles switch-system
      ;;
    Linux)
      dotfiles switch-system && dotfiles switch-home
      ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      return 1
      ;;
    esac
    ;;
  switch-system)
    case "$(uname -s)" in
    Darwin)
      DOTFILES_DIR="$dir" nh darwin switch --ask "$dir" -- --impure
      ;;
    Linux)
      (
        tmp_dir="$(mktemp -d)"
        trap 'rm -rf "$tmp_dir"' EXIT INT TERM
        cd "$tmp_dir" || exit 1
        host="$(uname -n)"
        host="${host%%.*}"
        if command -v system-manager >/dev/null 2>&1; then
          sudo env "PATH=$PATH" system-manager switch --flake "$dir#$host"
        else
          sudo env "PATH=$PATH" nix run 'github:numtide/system-manager/release-26.05' -- switch --flake "$dir#$host"
        fi
      )
      ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      return 1
      ;;
    esac
    ;;
  switch-home)
    DOTFILES_DIR="$dir" nh home switch --ask "$dir" -- --impure
    ;;
  update)
    (cd "$dir" && nix flake update)
    ;;
  check)
    (cd "$dir" && nix flake check)
    ;;
  *)
    echo "dotfiles: unknown command '$cmd'" >&2
    dotfiles help >&2
    return 1
    ;;
  esac
}

function _dotfiles() {
  # shellcheck disable=SC2034
  local -a subcommands=(
    'init:Save clone path and run the initial system/home switch'
    'switch:Switch the full configuration for the current OS'
    'switch-system:Switch system layer (nix-darwin / system-manager)'
    'switch-home:Switch standalone Home Manager'
    'update:Update flake inputs'
    'check:Run pure flake checks'
    'help:Show usage'
  )
  _describe 'command' subcommands
}
type compdef >/dev/null 2>&1 && compdef _dotfiles dotfiles

function ssh() {
  if [[ "$TERM" == "xterm-kitty" && -z "${TMUX:-}" ]] && command -v kitten >/dev/null 2>&1; then
    kitten ssh "$@"
  else
    command ssh "$@"
  fi
}

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
