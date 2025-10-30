#!/bin/zsh

CWD=${0:a:h}

calendar=(
  icon=󰃭
  label.align=right
  update_freq=20
  script="$CWD/script.sh"
)

sketchybar --add item calendar right \
  --set calendar "${calendar[@]}" \
  --subscribe calendar system_woke
