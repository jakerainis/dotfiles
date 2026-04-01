#!/usr/bin/env bash
# ExchangeFlo development session
PROJECT="$HOME/Development/exchange-flo-app"

# Window 1: exchangeflo (2x2 grid)
tmux rename-window "exchangeflo"
tmux send-keys "cd $PROJECT/apps/ef_workers" Enter
tmux split-window -h -c "$PROJECT/apps/ef_call_api"
tmux select-pane -t 0
tmux split-window -v -c "$PROJECT/apps/ef_portal"
tmux select-pane -t 2
tmux split-window -v -c "$PROJECT/apps/ef_publisher_api"
tmux select-layout tiled

# Window 2: wringer (2x2 grid)
tmux new-window -n "wringer" -c "$PROJECT/apps/wr_workers"
tmux split-window -h -c "$PROJECT/apps/wr_event_api"
tmux select-pane -t 0
tmux split-window -v -c "$PROJECT/apps/wr_portal"
tmux select-pane -t 2
tmux split-window -v -c "$PROJECT/apps/wr_service_api"
tmux select-layout tiled

# Window 3: nvim
tmux new-window -n "nvim" -c "$PROJECT"
tmux send-keys "nvim" Enter
tmux split-window -h -p 20 -c "$DIR"

# Window 4: system (2x2 grid)
tmux new-window -n "system" -c "$PROJECT"
tmux send-keys "efd" Enter
tmux split-window -h -c "$PROJECT"
tmux send-keys "btop" Enter
tmux select-pane -t 0
tmux split-window -v -c "$PROJECT"
tmux select-pane -t 2
tmux split-window -v -c "$PROJECT"
tmux send-keys "k9s" Enter
tmux select-layout tiled

# Focus nvim window
tmux select-window -t "nvim"
