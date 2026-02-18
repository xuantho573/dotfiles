#!/bin/bash

CWD=$(dirname "${BASH_SOURCE[0]}")

bluetooth=(
  icon="$BT_OFF"
  icon.padding_left="$PADDING_MD"
  icon.padding_right="$PADDING_MD"

  label.drawing=off
  script="$CWD/script.sh"
  background.padding_right=0
  padding_left=0
)

sketchybar --add event bluetooth_update "com.apple.bluetooth.status" \
  --add event bluetooth_device_connected "com.apple.bluetooth.deviceconnected" \
  --add event bluetooth_device_disconnected "com.apple.bluetooth.devicedisconnected" \
  --add item bluetooth right --set bluetooth "${bluetooth[@]}" \
  --subscribe bluetooth mouse.clicked mouse.entered mouse.exited bluetooth_update bluetooth_device_connected bluetooth_device_disconnected
