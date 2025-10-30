#!/bin/zsh

CWD=${0:a:h}

battery=(
  script="./battery/script.sh"
  icon.color=$TEXT
  update_freq=120
  background.padding_left=$PADDING_MD
)

sketchybar --add item battery right \
  --set battery "${battery[@]}" \
  --subscribe battery power_source_change system_woke
