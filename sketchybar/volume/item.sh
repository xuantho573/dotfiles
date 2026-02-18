#!/bin/bash

CWD=$(dirname "${BASH_SOURCE[0]}")

volume_slider=(
  script="$CWD/slider_script.sh"
  label.drawing=off
  icon.drawing=off
  background.drawing=off
  slider.background.height=4
  slider.knob="􀀁 "
  slider.knob.drawing=off
  padding_left=0
  padding_right=0
)

volume_icon=(
  script="$CWD/icon_script.sh"
  background.drawing=off

  padding_right=0
  padding_left=0

  icon.padding_left="$PADDING_MD"
  icon.padding_right="$PADDING_MD"

  label.drawing=off
)

sketchybar --add slider volume right \
  --set volume "${volume_slider[@]}" \
  --subscribe volume volume_change mouse.clicked mouse.entered mouse.exited

sketchybar --add item volume_icon right \
  --set volume_icon "${volume_icon[@]}" \
  --subscribe volume_icon mouse.clicked mouse.entered mouse.exited
