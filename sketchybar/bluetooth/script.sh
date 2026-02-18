#!/bin/bash
# shellcheck disable=SC2153,SC1091

CWD=$(dirname "${BASH_SOURCE[0]}")
POPUP_ITEM_WIDTH=320

toggle_status() {
  blueutil -p toggle
}

sync_status() {
  source "./icons.sh"
  state=$(echo "$INFO" | jq -c '.POWER_STATE')
  if [ "$state" -eq 0 ]; then
    sketchybar --set "$NAME" icon="$BT_OFF" icon.highlight=off
  elif [ "$state" -eq 1 ]; then
    sketchybar --set "$NAME" icon="$BT_ON" icon.highlight=on
  fi
}

toggle_devices() {
  source "./config.sh"

  ARGS=(--remove '/bluetooth.device\.*/' --set "$NAME" popup.align=right popup.drawing=toggle)

  add_args() {
    name=$(echo "$1" | jq -r '.name')
    address=$(echo "$1" | jq -r '.address')
    connected=$(echo "$1" | jq -r '.connected')
    [[ $connected = "true" ]] && highlight=on || highlight=off

    ARGS+=(
      --add item bluetooth.device."$address" popup."$NAME"
      --set bluetooth.device."$address" label="${name}"
      label.highlight="$highlight"
      label.padding_left="$PADDING_LG"
      script="$CWD/device_script.sh $address"
      icon.drawing=off
      background.drawing=off
      width="$POPUP_ITEM_WIDTH"
      --subscribe bluetooth.device."$address" mouse.clicked mouse.entered mouse.exited
    )
  }

  connected=$(blueutil --connected --format json | jq -c '.[]')
  paired=$(blueutil --paired --format json | jq -c '.[] | select(.connected == false)')

  [[ -n "$connected" ]] && while IFS= read -r device; do
    add_args "$device"
  done <<<"$connected"

  [[ -n "$paired" ]] && while IFS= read -r device; do
    add_args "$device"
  done <<<"$paired"

  sketchybar -m "${ARGS[@]}" >/dev/null
}

case "$SENDER" in
"mouse.clicked")
  if [ "$BUTTON" = "left" ]; then
    toggle_devices
  else
    toggle_status
  fi
  ;;
"mouse.entered")
  sketchybar --set "$NAME" background.drawing=on
  ;;
"mouse.exited")
  sketchybar --set "$NAME" background.drawing=off
  ;;
"bluetooth_update" | "bluetooth_device_connected" | "bluetooth_device_disconnected")
  sync_status
  ;;
esac
