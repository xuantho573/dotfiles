#!/bin/bash

close_popup() {
  sketchybar --set apple.logo popup.drawing=close
}

toggle_popup() {
  sketchybar --set apple.logo popup.drawing=toggle
}

case "$SENDER" in
"mouse.clicked")
  case "$NAME" in
  "apple.logo")
    toggle_popup
    ;;
  "apple.prefs")
    open -a 'System Preferences'
    close_popup
    ;;
  "apple.activity")
    open -a 'Activity Monitor'
    close_popup
    ;;
  "apple.lock")
    pmset displaysleepnow
    close_popup
    ;;
  esac
  ;;
"mouse.entered")
  case "$NAME" in
  "apple.logo") ;;
  *)
    sketchybar --set "$NAME" background.drawing=on
    ;;
  esac
  ;;
"mouse.exited")
  case "$NAME" in
  "apple.logo") ;;
  *)
    sketchybar --set "$NAME" background.drawing=off
    ;;
  esac
  ;;
esac
