#!/bin/zsh

CWD=${0:a:h}

yabai=(
  script="$CWD/yabai.sh"
  associated_display=active

  label.drawing=off
  icon.drawing=off
  background.drawing=off

  padding_left=0
  padding_right=0
)

front_app=(
  script="$CWD/script.sh"
  padding_left=0
  label.color=$BASE

  icon.drawing=on
  icon.font="$ICON_FONT:Regular:$ICON_SIZE"
  icon.color=$BASE

  associated_display=active

  background.drawing=off
)

sketchybar --add event window_focus \
  --add event windows_on_spaces \
  --add item yabai left \
  --set yabai "${yabai[@]}" \
  --subscribe yabai window_focus windows_on_spaces

sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched
