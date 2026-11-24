#!/usr/bin/env sh
# Open a tmux popup with a backdrop (by dimming the window behind it).
#
# Usage (from a binding, via run-shell so the formats get expanded):
#   run-shell "popup.sh '#{window_id}' '#{client_name}' [display-popup args...] [command]"
#
# tmux has no popup backdrop, so fake one: style the window behind the popup
# while it is open, then restore it. Must run under run-shell, where
# display-popup blocks until the popup closes.
# Strength: @popup_backdrop_alpha (percent to darken, default 15).

window=$1
client=$2
shift 2

alpha=$(tmux show -gqv @popup_backdrop_alpha)
alpha=${alpha:-15}

if [ "$(tmux display -p '#{>=:#{version},3.8}')" = 1 ]; then
  # tmux 3.8+: dim= darkens every cell, including app colours (nvim etc.).
  # See https://github.com/tmux/tmux/issues/4842
  style="dim=${alpha}%"
else
  # Older tmux: only the default background can be changed, so blend black
  # over the theme bg. Cells with app-set colours stay as they are.
  bg=$(tmux show -gqv @thm_bg)
  bg=${bg#\#}
  bg=${bg:-ffffff}
  rgb=""
  for i in 1 3 5; do
    c=$(printf '%d' "0x$(printf '%s' "$bg" | cut -c"$i-$((i + 1))")")
    rgb="$rgb$(printf '%02x' $((c * (100 - alpha) / 100)))"
  done
  style="bg=#$rgb"
fi

restore() {
  tmux set -wu -t "$window" window-style \; set -wu -t "$window" window-active-style
}
trap restore EXIT INT TERM

tmux set -w -t "$window" window-style "$style" \; set -w -t "$window" window-active-style "$style"
tmux display-popup -c "$client" -E "$@"
