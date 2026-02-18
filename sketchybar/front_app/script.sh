#!/bin/bash

update_info() {
  sketchybar --set "$NAME" icon="$(./icon_map.sh "$INFO")" label="$INFO"
}

case "$SENDER" in
"front_app_switched")
  update_info
  ;;
esac
