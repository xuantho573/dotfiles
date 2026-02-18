#!/bin/bash

CWD=$(dirname "${BASH_SOURCE[0]}")

volume_change() {
  source "$CWD/icon_script.sh"

  case $INFO in
  [6-9][0-9] | 100) ICON=􀊩 ;;
  [3-5][0-9]) ICON=􀊧 ;;
  [1-2][0-9]) ICON=􀊥 ;;
  [1-9]) ICON=􀊡 ;;
  0) ICON=􀊣 ;;
  *) ICON=􀊩 ;;
  esac

  sketchybar --set volume_icon icon=$ICON \
    --set "$NAME" slider.percentage="$INFO"

  detail_on

  sleep 2

  # Check wether the volume was changed another time while sleeping
  FINAL_PERCENTAGE=$(sketchybar --query "$NAME" | jq -r ".slider.percentage")
  if [ "$FINAL_PERCENTAGE" -eq "$INFO" ]; then
    detail_off
  fi
}

case "$SENDER" in
"volume_change")
  volume_change
  ;;
"mouse.clicked")
  osascript -e "set volume output volume $PERCENTAGE"
  ;;
"mouse.entered")
  sketchybar --set "$NAME" slider.knob.drawing=on
  ;;
"mouse.exited")
  sketchybar --set "$NAME" slider.knob.drawing=off
  ;;
esac
