#!/bin/bash

ADDRESS="$1"

connect() {
  blueutil --connect "$ADDRESS"
  sketchybar --set "$NAME" label.highlight=on
}

disconnect() {
  blueutil --disconnect "$ADDRESS"
  sketchybar --set "$NAME" label.highlight=off
}

case "$SENDER" in
"mouse.clicked")
  if [[ $(blueutil --info "$ADDRESS" --format json | jq -c '.connected') = "true" ]]; then
    disconnect "$ADDRESS"
  else
    connect "$ADDRESS"
  fi
  ;;
"mouse.entered")
  sketchybar --set "$NAME" background.drawing=on
  ;;
"mouse.exited")
  sketchybar --set "$NAME" background.drawing=off
  ;;
esac
