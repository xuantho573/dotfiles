#!/bin/zsh

CWD=${0:a:h}

volume_slider=(
  script="$CWD/slider_script.sh"
  label.drawing=off
  icon.drawing=off
  background.drawing=off
  slider.highlight_color=$SKY
  slider.background.height=4
  slider.background.color=$BACKGROUND_2
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

  label.padding_left=$PADDING_MD
  label.padding_right=$PADDING_MD

  icon.drawing=off
)

sketchybar --add slider volume right \
  --set volume "${volume_slider[@]}" \
  --subscribe volume volume_change mouse.clicked mouse.entered mouse.exited

sketchybar --add item volume_icon right \
  --set volume_icon "${volume_icon[@]}" \
  --subscribe volume_icon mouse.clicked mouse.entered mouse.exited
