#!/usr/bin/env bash
# ExchangeFlo development session
SESSION="${1:-exchangeflo}"
PROJECT="${2:-$HOME/Development/ef}"
direnv allow "$PROJECT" 2>/dev/null

# Reattach if session already exists
if tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux attach-session -t "$SESSION"
  exit 0
fi

COLS=$(tput cols)
LINES=$(tput lines)

# Window 1: apps (4 columns x 2 rows)
# Top row: ef apps
tmux new-session -d -s "$SESSION" -c "$PROJECT/apps/ef_workers" -n "apps" -x "$COLS" -y "$LINES"
tmux split-window -h -t "$SESSION:apps" -c "$PROJECT/apps/ef_call_api"
tmux split-window -h -t "$SESSION:apps" -c "$PROJECT/apps/ef_publisher_api"
tmux split-window -h -t "$SESSION:apps" -c "$PROJECT/apps/ef_portal"
tmux select-layout -t "$SESSION:apps" even-horizontal

# Bottom row: wr apps (split each column vertically, right to left)
# Pane indices start at 1 (because of base-index 1 in tmux.conf)
tmux split-window -v -t "$SESSION:apps.4" -c "$PROJECT/apps/wr_portal"
tmux split-window -v -t "$SESSION:apps.3" -c "$PROJECT/apps/wr_service_api"
tmux split-window -v -t "$SESSION:apps.2" -c "$PROJECT/apps/wr_event_api"
tmux split-window -v -t "$SESSION:apps.1" -c "$PROJECT/apps/wr_workers"

# Window 2: nvim
tmux new-window -t "$SESSION" -n "nvim" -c "$PROJECT"
tmux send-keys -t "$SESSION:nvim" "nvim" Enter
tmux split-window -h -t "$SESSION:nvim" -l 20% -c "$PROJECT"

# Focus nvim window
tmux select-window -t "$SESSION:nvim"
