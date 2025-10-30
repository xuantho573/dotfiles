#!/bin/zsh

CWD=${0:a:h}

VOLUME_100=􀊩
VOLUME_66=􀊧
VOLUME_33=􀊥
VOLUME_10=􀊡
VOLUME_0=􀊣

volume_change() {
  source "$(dirname $CWD)/icons.sh"
  source "$CWD/icon_script.sh"

  case $INFO in
  [6-9][0-9] | 100)
    ICON=􀊩
    ;;
  [3-5][0-9])
    ICON=􀊧
    ;;
  [1-2][0-9])
    ICON=􀊥
    ;;
  [1-9])
    ICON=􀊡
    ;;
  0)
    ICON=􀊣
    ;;
  *)
    ICON=􀊩
    ;;
  esac

  sketchybar --set volume_icon label=$ICON

  sketchybar --set $NAME slider.percentage=$INFO

  detail_on

  sleep 2

  # Check wether the volume was changed another time while sleeping
  FINAL_PERCENTAGE=$(sketchybar --query $NAME | jq -r ".slider.percentage")
  if [ "$FINAL_PERCENTAGE" -eq "$INFO" ]; then
    detail_off
  fi
}

mouse_clicked() {
  osascript -e "set volume output volume $PERCENTAGE"
}

mouse_entered() {
  sketchybar --set $NAME slider.knob.drawing=on
}

mouse_exited() {
  sketchybar --set $NAME slider.knob.drawing=off
}

case "$SENDER" in
"volume_change")
  volume_change
  ;;
"mouse.clicked")
  mouse_clicked
  ;;
"mouse.entered")
  mouse_entered
  ;;
"mouse.exited")
  mouse_exited
  ;;
esac
