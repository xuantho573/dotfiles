#!/bin/zsh

CWD=${0:a:h}

toggle_status() {
  blueutil -p toggle
}

sync_status() {
  source "$(dirname $CWD)/icons.sh"
  state=$(echo "$INFO" | jq -c '.POWER_STATE')
  if [ "$state" -eq 0 ]; then
    sketchybar --set "$NAME" icon=$BT_OFF icon.highlight=off
  elif [ "$state" -eq 1 ]; then
    sketchybar --set "$NAME" icon=$BT_ON icon.highlight=on
  fi
}

toggle_devices() {
  source "$(dirname $CWD)/colors.sh"
  source "$(dirname $CWD)/config.sh"

  ARGS=(--remove '/bluetooth.device\.*/' --set "$NAME" popup.align=right popup.drawing=toggle)

  add_args() {
    name=$(echo "$1" | jq -r '.name')
    address=$(echo "$1" | jq -r '.address')
    connected=$(echo "$1" | jq -r '.connected')
    color=$TEXT
    if [[ $connected = "true" ]]; then
      color=$SKY
    fi

    ARGS+=(
      --add item bluetooth.device.$COUNTER popup."$NAME"
      --set bluetooth.device.$COUNTER label="${name}"
      label.color="${color}"
      label.padding_left=$PADDING_LG
      click_script="$CWD/device_click_script.sh $address"
      icon.drawing=off
      background.drawing=off
    )
  }

  COUNTER=0
  connected=$(blueutil --connected --format json | jq -c '.[]')
  paired=$(blueutil --paired --format json | jq -c '.[] | select(.connected == false)')

  if [[ $connected != "" ]]; then
    while IFS= read -r device; do
      add_args $device
      COUNTER=$((COUNTER + 1))
    done <<<$connected
  fi

  if [[ $paired != "" ]]; then
    while IFS= read -r device; do
      add_args $device
      COUNTER=$((COUNTER + 1))
    done <<<$paired
  fi

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
"bluetooth_update")
  sync_status
  ;;
esac
