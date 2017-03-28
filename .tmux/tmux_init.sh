#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 layout_name" >&2
    exit 1
fi

CTMUX_PATH=$HOME/.tmux/$1

if ! [ -e "$CTMUX_PATH" ]; then
    echo "$CTMUX_PATH not found" >&2
    exit 1
fi

tmux attach -t "$1" || tmux new-session -s "$1" 'tmux move-window -t 99 \; source-file '"$CTMUX_PATH"
