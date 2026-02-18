#!/bin/bash

case "$SENDER" in
"mouse.clicked")
  NUMBER=$(("$SID" % 10))
  case "$NUMBER" in
  0) KEYCODE=29 ;;
  1) KEYCODE=18 ;;
  2) KEYCODE=19 ;;
  3) KEYCODE=20 ;;
  4) KEYCODE=21 ;;
  5) KEYCODE=23 ;;
  6) KEYCODE=22 ;;
  7) KEYCODE=26 ;;
  8) KEYCODE=28 ;;
  9) KEYCODE=25 ;;
  esac

  if [[ "$SID" -gt 10 ]]; then
    MODIFIER="{ control down, option down }"
  else
    MODIFIER="control down"
  fi

  osascript -e "tell app \"System Events\" to key code $KEYCODE using $MODIFIER"
  ;;
*)
  sketchybar --set "$NAME" icon.highlight="$SELECTED" label.highlight="$SELECTED"
  ;;
esac
