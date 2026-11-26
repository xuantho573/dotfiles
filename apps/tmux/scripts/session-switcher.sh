#!/usr/bin/env sh
# fzf session switcher, meant to run inside a tmux popup.
#
# Sessions are listed most recently used first (current one on top) and
# numbered from 0. Type to fuzzy search names, Enter to switch, or press 0-9 to
# switch to that number directly (like choose-tree; digits can't be typed into
# the search). fzf prints the chosen number, which is mapped back to the name.

list=$(
  tmux list-sessions -F '#{session_last_attached} #{session_name}' |
    sort -rn |
    cut -d' ' -f2- |
    nl -ba -v0 -w1
)

binds=""
for d in 0 1 2 3 4 5 6 7 8 9; do
  binds="$binds${binds:+,}$d:become(echo $d)"
done

index=$(
  printf '%s\n' "$list" |
    fzf --reverse --cycle --no-preview --prompt='session> ' \
      --delimiter='\t' --nth=2.. --accept-nth=1 --tabstop=3 \
      --bind "$binds"
) || exit 0
[ -n "$index" ] || exit 0

session=$(printf '%s\n' "$list" | sed -n "$((index + 1))p" | cut -f2-)
[ -n "$session" ] && tmux switch-client -t "=$session"
