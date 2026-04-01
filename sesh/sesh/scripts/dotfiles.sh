#!/usr/bin/env bash
# Dotfiles session
DIR="$HOME/dotfiles"

tmux rename-window "dotfiles"
tmux send-keys "cd $DIR && nvim ." Enter
tmux split-window -h -p 20 -c "$DIR"
