#!/bin/zsh

CWD=${0:a:h}

for ((sid = 1; sid <= 16; sid++)); do
  space=(
    associated_space=$sid
    script="$CWD/script.sh"

    background.padding_left=0
    background.padding_right=$PADDING_SM

    icon=$sid
    icon.color=$TEXT
    icon.highlight_color=$SKY
    icon.font="$FONT:Bold:$LABEL_SIZE"
    icon.padding_left=$PADDING_MD
    icon.padding_right=0

    label.font="$ICON_FONT:Regular:$ICON_SIZE"
    label.padding_left=0
    label.highlight_color=$SKY
  )

  sketchybar --add space space.$sid left \
    --set space.$sid "${space[@]}" \
    --subscribe space.$sid mouse.clicked
done
