#!/usr/bin/env bash
# ExchangeFlo development session — one layout, two entry points:
#   template (tbc/tmc):    exchangeflo.sh <session> [project_dir]   → creates the session
#   sesh startup_command:  exchangeflo.sh                           → lays out the session sesh just made

if [ -n "${1:-}" ]; then
  # Template mode: create (or reattach) a named session.
  SESSION="$1"
  PROJECT="${2:-$HOME/Development/ef}"
  direnv allow "$PROJECT" 2>/dev/null
  if tmux has-session -t "$SESSION" 2>/dev/null; then
    tmux attach-session -t "$SESSION" 2>/dev/null || tmux switch-client -t "$SESSION"
    exit 0
  fi
  COLS=$(tput cols)
  LINES=$(tput lines)
  tmux new-session -d -s "$SESSION" -c "$PROJECT/apps/ef_workers" -n "apps" -x "$COLS" -y "$LINES"
else
  # Wildcard mode: sesh already created + attached the session; lay out this one.
  PANE="$TMUX_PANE"
  SESSION="$(tmux display-message -p -t "$PANE" '#S')"
  PROJECT="$(tmux display-message -p -t "$PANE" '#{pane_current_path}')"
  tmux rename-window -t "$PANE" "apps"
  tmux send-keys -t "$PANE" "cd '$PROJECT/apps/ef_workers' && clear" Enter
fi

# Window 1: apps (4 columns x 2 rows)
# Top row: ef apps
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
