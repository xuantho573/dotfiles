#!/bin/zsh

CWD=${0:a:h}

windows_on_spaces() {
  CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"

  args=()
  while read -r line; do
    spaces=($(grep -Eo '[[:digit:]]+' <<<"$line"))
    for space in "${spaces[@]}"; do
      icon_strip=" "
      apps=$(yabai -m query --windows --space $space | jq -r ".[].app")
      if [ "$apps" != "" ]; then
        while IFS= read -r app; do
          icon_strip+="$($(dirname $CWD)/icon_map.sh $app)"
        done <<<"$apps"
      fi
      args+=(--set space.$space label="$icon_strip")
    done
  done <<<"$CURRENT_SPACES"

  sketchybar -m "${args[@]}"
}

case "$SENDER" in
"forced")
  exit 0
  ;;
"windows_on_spaces")
  windows_on_spaces
  ;;
esac
