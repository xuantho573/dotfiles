#!/bin/bash
# shellcheck disable=SC1091

CWD=$(dirname "${BASH_SOURCE[0]}")

detail_on() {
  sketchybar --animate tanh 20 --set volume slider.width=100
}

detail_off() {
  sketchybar --animate tanh 20 --set volume slider.width=0
}

toggle_detail() {
  INITIAL_WIDTH=$(sketchybar --query volume | jq -r ".slider.width")
  if [ "$INITIAL_WIDTH" -eq "0" ]; then
    detail_on
  else
    detail_off
  fi
}

toggle_devices() {
  source "./config.sh"

  args=(--remove '/volume.device\.\d*/' --set "$NAME" popup.align=right popup.drawing=toggle)
  current_device_uid="$(SwitchAudioSource -t output -c -f json | jq -r '.uid')"
  while IFS= read -r device; do
    device_uid=$(echo "$device" | jq -r '.uid')
    device_name=$(echo "$device" | jq -r '.name')
    [[ "$device_uid" = "$current_device_uid" ]] && highlight=on || highlight=off
    args+=(
      --add item volume.device."$device_uid" popup."$NAME"
      --set volume.device."$device_uid"
      label="${device_name}"
      label.highlight="$highlight"
      label.padding_left="$PADDING_LG"
      background.drawing=off
      icon.drawing=off
      width=200
      script="$CWD/device_script.sh \"${device_uid}\" $NAME"
      --subscribe volume.device."$device_uid" mouse.clicked mouse.entered mouse.exited
    )
  done <<<"$(SwitchAudioSource -a -t output -f json | jq -c '.')"
  sketchybar -m "${args[@]}" >/dev/null
}

case "$SENDER" in
"mouse.clicked")
  if [ "$BUTTON" = "right" ]; then
    toggle_devices
  else
    toggle_detail
  fi
  ;;
"mouse.entered")
  sketchybar --set "$NAME" background.drawing=on
  ;;
"mouse.exited")
  sketchybar --set "$NAME" background.drawing=off
  ;;
esac
