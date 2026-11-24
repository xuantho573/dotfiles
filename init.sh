#!/usr/bin/env sh
set -eu

DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
STATE_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles-flake-dir"
NIX_FLAGS="--extra-experimental-features nix-command --extra-experimental-features flakes"

if ! command -v nix >/dev/null 2>&1; then
  for p in /nix/var/nix/profiles/default/bin "$HOME/.nix-profile/bin"; do
    if [ -x "$p/nix" ]; then
      PATH="$p:$PATH"
      export PATH
      break
    fi
  done
fi

if ! command -v nix >/dev/null 2>&1; then
  echo "Error: 'nix' not found in PATH. Install Nix and try again." >&2
  exit 1
fi

mkdir -p "$(dirname -- "$STATE_FILE")"
printf '%s\n' "$DIR" >"$STATE_FILE"
echo "Saved dotfiles path: $DIR -> $STATE_FILE"

WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT INT TERM
cd "$WORK_DIR"

case "$(uname -s)" in
Darwin)
  if command -v nh >/dev/null 2>&1; then
    DOTFILES_DIR="$DIR" nh darwin switch --ask "$DIR" -- --impure
  elif command -v darwin-rebuild >/dev/null 2>&1; then
    sudo env "PATH=$PATH" "DOTFILES_DIR=$DIR" darwin-rebuild switch --flake "$DIR#M4" --impure
  else
    # shellcheck disable=SC2086
    sudo env "PATH=$PATH" "DOTFILES_DIR=$DIR" nix $NIX_FLAGS run nix-darwin -- switch --flake "$DIR#M4" --impure
  fi
  ;;
Linux)
  if command -v system-manager >/dev/null 2>&1; then
    sudo env "PATH=$PATH" "DOTFILES_DIR=$DIR" system-manager switch --flake "$DIR#optiplex-arch"
  else
    # shellcheck disable=SC2086
    sudo env "PATH=$PATH" "DOTFILES_DIR=$DIR" nix $NIX_FLAGS run 'github:numtide/system-manager/release-26.05' -- switch --flake "$DIR#optiplex-arch"
  fi

  if command -v nh >/dev/null 2>&1; then
    DOTFILES_DIR="$DIR" nh home switch --ask "$DIR" -c "xuantho573@optiplex-arch" -- --impure
  elif command -v home-manager >/dev/null 2>&1; then
    DOTFILES_DIR="$DIR" home-manager switch --flake "$DIR#xuantho573@optiplex-arch" --impure
  else
    # shellcheck disable=SC2086
    DOTFILES_DIR="$DIR" nix $NIX_FLAGS run 'github:nix-community/home-manager/release-26.05' -- switch --flake "$DIR#xuantho573@optiplex-arch" --impure
  fi
  ;;
*)
  echo "Unsupported OS: $(uname -s)" >&2
  exit 1
  ;;
esac
