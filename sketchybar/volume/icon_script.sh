#!/bin/zsh

CWD=${0:a:h}

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
  source "$(dirname $CWD)/colors.sh"
  source "$(dirname $CWD)/config.sh"

  args=(--remove '/volume.device\.*/' --set "$NAME" popup.align=right popup.drawing=toggle)
  COUNTER=0
  CURRENT="$(SwitchAudioSource -t output -c)"
  while IFS= read -r device; do
    COLOR=$TEXT
    if [ "${device}" = "$CURRENT" ]; then
      COLOR=$SKY
    fi
    args+=(
      --add item volume.device.$COUNTER popup."$NAME"
      --set volume.device.$COUNTER
      label="${device}"
      label.color="$COLOR"
      label.padding_left=$PADDING_LG
      background.drawing=off
      icon.drawing=off
      width=200
      click_script="$CWD/sound_output_click_script.sh \"${device}\" $NAME"
    )
    COUNTER=$((COUNTER + 1))
  done <<<"$(SwitchAudioSource -a -t output)"
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
