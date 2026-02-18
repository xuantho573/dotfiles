#!/bin/bash

CWD=$(dirname "${BASH_SOURCE[0]}")

calendar=(
  icon=󰃭
  label.align=right
  update_freq=20
  script="$CWD/script.sh"
)

sketchybar --add item calendar right \
  --set calendar "${calendar[@]}" \
  --subscribe calendar system_woke
