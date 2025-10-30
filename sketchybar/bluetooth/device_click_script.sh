#!/bin/zsh

CWD=${0:a:h}

source "$(dirname $CWD)/colors.sh"

connect() {
  blueutil --connect "$1"
  sketchybar --set "$NAME" label.color=$SKY
}

disconnect() {
  blueutil --disconnect "$1"
  sketchybar --set "$NAME" label.color=$TEXT
}

if [[ $(blueutil --info "$1" --format json | jq -c '.connected') = "true" ]]; then
  disconnect "$1"
else
  connect "$1"
fi
