#!/bin/bash

case "$SENDER" in
*)
  sketchybar --set "$NAME" label="$(date '+%a %d %b') $(date '+%H:%M')"
  ;;
esac
