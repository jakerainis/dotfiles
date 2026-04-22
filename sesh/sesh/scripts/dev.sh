#!/usr/bin/env bash
# Generic dev session — nvim (80%) + terminal (20%)
SESSION="${1:-dev}"
DIR="${2:-$(pwd)}"

if tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux attach-session -t "$SESSION"
  exit 0
fi

tmux new-session -d -s "$SESSION" -c "$DIR" -n "dev"
tmux send-keys -t "$SESSION:dev" "nvim ." Enter
tmux split-window -h -t "$SESSION:dev" -l 20% -c "$DIR"

tmux select-window -t "$SESSION:dev"
