#!/bin/bash

if [[ "$SENDER" != "theme_change" ]]; then
  exit 0
fi

mode="$(defaults read -g AppleInterfaceStyle 2>/dev/null)"
if [ "$mode" = "Dark" ]; then
  source ./colors_dark.sh
else
  source ./colors_light.sh
fi

primary_item_style=(
  icon.color="$TEXT"
  icon.highlight_color="$SKY"
  label.color="$TEXT"
  label.highlight_color="$SKY"
  background.color="$BASE"
  popup.background.color="$CRUST"
)

secondary_item_style=(
  icon.color="$BASE"
  label.color="$BASE"
  background.color="$TEXT"
  popup.background.color="$CRUST"
)

hoverable_primary_item_style=(
  icon.color="$TEXT"
  icon.highlight_color="$SKY"
  label.color="$TEXT"
  background.color="$CRUST"
  background.drawing=off
  popup.background.color="$CRUST"
)

slider_item_style=(
  slider.knob.color="$TEXT"
  slider.knob.drawing=off
  slider.highlight_color="$SKY"
  slider.background.color="$MANTLE"
)

popup_item_style=(
  icon.color="$TEXT"
  icon.highlight_color="$SKY"
  label.color="$TEXT"
  label.highlight_color="$SKY"
  background.color="$BASE"
  background.drawing=off
)

sketchybar --default "${primary_item_style[@]}" \
  --set status "${primary_item_style[@]}" \
  --set battery "${primary_item_style[@]}" \
  --set calendar "${primary_item_style[@]}" \
  --set /space\..*/ "${primary_item_style[@]}" \
  --set front_app "${secondary_item_style[@]}" \
  --set volume "${slider_item_style[@]}" \
  --set volume_icon "${hoverable_primary_item_style[@]}" \
  --set bluetooth "${hoverable_primary_item_style[@]}" \
  --set /bluetooth\.device.*/ "${popup_item_style[@]}" \
  --set /volume\.device.*/ "${popup_item_style[@]}" \
  --set apple.logo "${secondary_item_style[@]}" \
  --set apple.prefs "${popup_item_style[@]}" \
  --set apple.activity "${popup_item_style[@]}" \
  --set apple.lock "${popup_item_style[@]}"
