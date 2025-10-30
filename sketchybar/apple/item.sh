#!/bin/zsh

CWD=${0:a:h}
POPUP_ITEM_WIDTH=160

apple_logo=(
  icon=󰀵
  icon.color=$CRUST
  label.drawing=off
  background.drawing=off
  script="$CWD/script.sh"
)

apple_prefs=(
  icon=
  background.drawing=off
  label="Preferences"
  width=$POPUP_ITEM_WIDTH
  script="$CWD/script.sh"
)

apple_activity=(
  icon=
  background.drawing=off
  # background.color=$SKY
  # width=stretch
  label="Activity"
  width=$POPUP_ITEM_WIDTH
  script="$CWD/script.sh"
)

apple_lock=(
  icon=󰌾
  background.drawing=off
  label="Lock Screen"
  width=$POPUP_ITEM_WIDTH
  script="$CWD/script.sh"
)

sketchybar --add item apple.logo left \
  --set apple.logo "${apple_logo[@]}" \
  --subscribe apple.logo mouse.clicked \
  \
  --add item apple.prefs popup.apple.logo \
  --set apple.prefs "${apple_prefs[@]}" \
  --subscribe apple.prefs mouse.clicked mouse.entered mouse.exited \
  \
  --add item apple.activity popup.apple.logo \
  --set apple.activity "${apple_activity[@]}" \
  --subscribe apple.activity mouse.clicked mouse.entered mouse.exited \
  \
  --add item apple.lock popup.apple.logo \
  --set apple.lock "${apple_lock[@]}" \
  --subscribe apple.lock mouse.clicked mouse.entered mouse.exited
