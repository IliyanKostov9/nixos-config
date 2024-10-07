#!/usr/bin/env bash

session=$(tmux ls | sed 's/(\(created [^)]*\))//' | fzf --height=10 --layout=reverse --prompt="Delete tmux session: ")

session_id=$(echo "$session" | awk 'BEGIN { FS = ":" } ; { print $1 }')

if [ -n "$session_id" ]; then
    tmux kill-session -t $session_id
else
    echo "No session selected."
fi
