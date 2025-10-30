#!/bin/zsh

CWD=${0:a:h}

update_info() {
  sketchybar --set $NAME icon=$($(dirname $CWD)/icon_map.sh "$INFO") label="$INFO"
}

case "$SENDER" in
"front_app_switched")
  update_info
  ;;
esac
