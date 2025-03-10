#!/usr/bin/env bash

session=$(tmux ls | sed 's/(\(created [^)]*\))//' | fzf --height=10 --layout=reverse --prompt="Select tmux session: " --preview 'tmux list-windows -t {1}')

session_name=$(echo "$session" | awk 'BEGIN { FS = ":" } ; { print $1 }')

if [ -n "$session_name" ]; then
    tmux switch-client -t $session_name
else
    echo "No session selected."
fi
