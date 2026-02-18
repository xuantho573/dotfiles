#!/bin/bash

connect() {
  SwitchAudioSource -u "$1" >/dev/null
  sketchybar --set volume_icon popup.drawing=off
}

case "$SENDER" in
"mouse.clicked")
  connect "$1"
  ;;
"mouse.entered")
  sketchybar --set "$NAME" background.drawing=on
  ;;
"mouse.exited")
  sketchybar --set "$NAME" background.drawing=off
  ;;
esac
