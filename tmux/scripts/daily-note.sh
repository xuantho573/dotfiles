#!/usr/bin/env sh
# Open an Obsidian daily note (today, yesterday or tomorrow) in a tmux popup.
#
# Usage (from a binding, via run-shell so the formats get expanded):
#   run-shell "daily-note.sh popup '#{window_id}' '#{client_name}' '#{client_theme}' <day>"
# where <day> is today, yesterday or tomorrow. This opens popup.sh, which runs
# `daily-note.sh open <theme> <day>` inside the popup to start nvim.
#
# Popups don't answer nvim's OSC 11 background query (nvim falls back to dark),
# so the theme is passed in (from #{client_theme}). NVIM_NOTE_POPUP makes the
# nvim config skip plugins that add context about other files (bufferline, oil).

script_dir=$(cd "$(dirname "$0")" && pwd)

# Date shifted by $1 days (0, -1, +1), on both GNU (Linux) and BSD (macOS) date.
shifted_date() {
  if [ "$1" = 0 ]; then
    date '+%Y-%m-%d %a'
  else
    date -d "$1 day" '+%Y-%m-%d %a' 2>/dev/null || date -v"${1}d" '+%Y-%m-%d %a'
  fi
}

mode=$1
shift

case $mode in
popup)
  window=$1 client=$2 theme=${3:-dark} day=${4:-today}
  case $day in
  today) offset=0 label="Today's note" ;;
  yesterday) offset=-1 label="Yesterday's note" ;;
  tomorrow) offset=+1 label="Tomorrow's note" ;;
  *) echo "unknown day: $day" >&2 && exit 1 ;;
  esac
  exec "$script_dir/popup.sh" "$window" "$client" \
    -w 120 -h 80% -T "#[align=centre] $label ($(shifted_date "$offset")) " \
    "'$script_dir/daily-note.sh' open '$theme' '$day'"
  ;;
open)
  theme=${1:-dark} day=${2:-today}
  NVIM_NOTE_POPUP=1 exec nvim --cmd "set bg=$theme" +"Obsidian $day"
  ;;
*)
  echo "usage: daily-note.sh popup <window> <client> <theme> <day> | open <theme> <day>" >&2
  exit 1
  ;;
esac
