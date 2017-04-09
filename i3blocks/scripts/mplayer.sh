#!/bin/bash

case $BLOCK_BUTTON in
  1) playerctl next;;  # right click, mute/unmute
  3) playerctl previous;;  # right click, mute/unmute
esac

echo -n "["
playerctl metadata artist
echo -n " - "
playerctl metadata title
echo "]"
