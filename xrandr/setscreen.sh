#!/usr/bin/env bash

if [ -x "$(command -v polybar)" ]; then
    MONCNT=$(polybar --list-monitors | wc -l)
else
    MONCNT=$(xrandr -d :0 -q | grep ' connected' | wc -l)
fi

if [[ "$MONCNT" == "3" ]]; then
    source ~/.screenlayout/docked.sh
fi
