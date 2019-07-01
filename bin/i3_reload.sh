#!/usr/bin/env bash

[ -f ~/.config/i3/config.common ] && cat ~/.config/i3/config.common > ~/.config/i3/config
[ -f ~/.config/i3/config.local ] && cat ~/.config/i3/config.local >> ~/.config/i3/config
i3-msg reload
