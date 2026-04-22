#!/usr/bin/env bash
# Monitor session — k9s, btop, and terminal panes
SESSION="${1:-monitor}"
DIR="${2:-$HOME/Development/ef}"

if tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux attach-session -t "$SESSION"
  exit 0
fi

COLS=$(tput cols)
LINES=$(tput lines)

tmux new-session -d -s "$SESSION" -c "$DIR" -n "monitor" -x "$COLS" -y "$LINES"

# Split into left (75%) and right (25%)
tmux send-keys -t "$SESSION:monitor" "k9s" Enter
tmux split-window -h -t "$SESSION:monitor.1" -l 25% -c "$DIR"

# Left column: split 50/50 for btop below k9s
tmux split-window -v -t "$SESSION:monitor.1" -l 50% -c "$DIR"
tmux send-keys -t "$SESSION:monitor.2" "btop" Enter

# Right column: split into 4 stacked panes (each 25%)
tmux split-window -v -t "$SESSION:monitor.3" -l 75% -c "$DIR"
tmux split-window -v -t "$SESSION:monitor.4" -l 66% -c "$DIR"
tmux split-window -v -t "$SESSION:monitor.5" -l 50% -c "$DIR"

# Focus k9s pane
tmux select-pane -t "$SESSION:monitor.1"
