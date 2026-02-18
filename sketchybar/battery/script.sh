#!/bin/bash

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case ${PERCENTAGE} in
100)
  [[ "$CHARGING" != "" ]] && icon=󰂅 || icon=󰁹
  ;;
9[0-9])
  [[ "$CHARGING" != "" ]] && icon=󰂋 || icon=󰂂
  ;;
8[0-9])
  [[ "$CHARGING" != "" ]] && icon=󰂊 || icon=󰂁
  ;;
7[0-9])
  [[ "$CHARGING" != "" ]] && icon=󰢞 || icon=󰂀
  ;;
6[0-9])
  [[ "$CHARGING" != "" ]] && icon=󰂉 || icon=󰁿
  ;;
5[0-9])
  [[ "$CHARGING" != "" ]] && icon=󰢝 || icon=󰁾
  ;;
4[0-9])
  [[ "$CHARGING" != "" ]] && icon=󰂈 || icon=󰁽
  ;;
3[0-9])
  [[ "$CHARGING" != "" ]] && icon=󰂇 || icon=󰁼
  ;;
2[0-9])
  [[ "$CHARGING" != "" ]] && icon=󰂆 || icon=󰁻
  ;;
1[0-9])
  [[ "$CHARGING" != "" ]] && icon=󰢜 || icon=󰁺
  ;;
*)
  [[ "$CHARGING" != "" ]] && icon=󰢟 || icon=󰂎
  ;;
esac

sketchybar --set "$NAME" label="$PERCENTAGE%" icon="$icon"
