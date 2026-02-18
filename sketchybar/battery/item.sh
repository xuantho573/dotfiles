#!/bin/bash

CWD=$(dirname "${BASH_SOURCE[0]}")

battery=(
  script="$CWD/script.sh"
  update_freq=120
  background.padding_left="$PADDING_MD"
)

sketchybar --add item battery right \
  --set battery "${battery[@]}" \
  --subscribe battery power_source_change system_woke
