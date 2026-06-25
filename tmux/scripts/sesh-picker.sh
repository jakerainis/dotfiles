#!/usr/bin/env bash
# Sesh picker: tmux sessions + ~/Development/* dirs.
# Tmux sessions are annotated with Claude Code state:
#   ◐  busy   (claude spinner active)
#   ●  idle   (claude is running but waiting on user)
#      blank  (no claude in any pane)
# ctrl-x kills the highlighted tmux session and reloads the list.

# Detect Claude state for a session by inspecting each pane's
# current command (Claude renames itself to its version, e.g. "2.1.111")
# and the pane title (braille spinner glyph U+28xx = busy).
claude_state() {
  local sess="$1" busy=0 idle=0 cmd title hex
  while IFS=$'\t' read -r cmd title; do
    [[ "$cmd" =~ ^[0-9.]+$ ]] || continue
    hex=$(printf '%s' "$title" | head -c3 | od -An -tx1 | tr -d ' \n')
    case "$hex" in
      e2a0*|e2a1*|e2a2*|e2a3*) busy=1 ;;
      *) idle=1 ;;
    esac
  done < <(tmux list-panes -t "$sess" -F $'#{pane_current_command}\t#{pane_title}' 2>/dev/null)
  # Claude sparkle (✳): yellow=busy, grey=idle — ANSI palette, adapts to any theme.
  if   (( busy )); then printf '\033[33m✳\033[0m'
  elif (( idle )); then printf '\033[90m✳\033[0m'
  else                  printf ' '
  fi
}

list() {
  local sess state dir name
  while IFS= read -r sess; do
    [ -z "$sess" ] && continue
    state=$(claude_state "$sess")
    printf '%s\t%s\n' "$state" "$sess"
  done < <(tmux list-sessions -F '#S' 2>/dev/null)

  while IFS= read -r dir; do
    name=$(basename "$dir")
    tmux has-session -t "$name" 2>/dev/null && continue
    printf ' \t%s\n' "$dir"
  done < <(find ~/Development -mindepth 1 -maxdepth 1 -type d -not -name '.*' 2>/dev/null)
}

if [ "$1" = "--list" ]; then
  list
  exit 0
fi

pick=$(
  list | fzf \
    --reverse --ansi --no-sort \
    --delimiter=$'\t' \
    --with-nth=1,2 \
    --tabstop=2 \
    --prompt '⚡  ' \
    --header 'enter: connect   ctrl-x: kill session' \
    --bind "ctrl-x:execute-silent(tmux kill-session -t {2} 2>/dev/null)+reload($0 --list)"
)

[ -z "$pick" ] && exit 0
target=$(printf '%s' "$pick" | awk -F'\t' '{print $2}')
exec sesh connect "$target"
