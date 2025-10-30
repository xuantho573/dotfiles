#!/bin/zsh

CWD=${0:a:h}

bluetooth=(
  icon=$BT_OFF
  icon.highlight_color=$SKY
  icon.padding_left=$PADDING_MD
  icon.padding_right=$PADDING_MD

  label.drawing=off
  script="$CWD/script.sh"
  background.drawing=off
  background.padding_right=0
  padding_left=0
)

sketchybar --add event bluetooth_update "com.apple.bluetooth.status"

sketchybar --add item bluetooth right --set bluetooth "${bluetooth[@]}" \
  --subscribe bluetooth mouse.clicked mouse.entered mouse.exited bluetooth_update
