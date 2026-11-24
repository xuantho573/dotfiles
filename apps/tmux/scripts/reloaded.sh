#!/usr/bin/env bash
# Confirmation shown in a popup after reloading tmux.conf (prefix + r).
# The message is centred in the popup and counts down; closes when it reaches
# zero or on any key.

seconds=5

read -r rows cols < <(stty size)

# Clear the popup and draw the given lines centred in it.
draw() {
  printf '\e[H\e[2J'
  for ((i = 0; i < (rows - $#) / 2; i++)); do printf '\n'; done
  for line in "$@"; do
    printf '%*s%s\n' $(((cols - ${#line}) / 2)) '' "$line"
  done
}

# Hide the cursor while waiting.
printf '\e[?25l'

for ((left = seconds; left > 0; left--)); do
  draw 'Config reloaded!' "(Closes in ${left}s or press any key...)"
  # A key press ends early; a 1s timeout moves on to the next second.
  read -r -n 1 -t 1 -s && break
done

# Always exit cleanly: run-shell would print a non-zero status in the status line.
exit 0
