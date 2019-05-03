#!/bin/bash

case $BLOCK_BUTTON in
  1) playerctl next;;  # right click, mute/unmute
  3) playerctl previous;;  # right click, mute/unmute
esac

playerctl --player=spotify metadata -f "[{{ artist }} - {{ title }}]"
# echo -n "["
# playerctl metadata artist
# echo -n " - "
# playerctl metadata title
# echo "]"
