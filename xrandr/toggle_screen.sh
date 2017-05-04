#!/bin/bash

# Install in /usr/local/bin/toggle_screen.sh
# install appropriate udev rule


USER="$(who | grep :0\) | cut -f 1 -d ' ')"
export XAUTHORITY=/home/$USER/.Xauthority
export DISPLAY=:0

########### Settings ###########

# Use 'xrandr' to find these
DP="DP-1"
VGA="VGA-1"
HDMI="HDMI-1"
INTERNAL_DISPLAY="eDP-1"

# Check /sys/class/drm for the exact location
DP_STATUS="$(cat /sys/class/drm/card0-DP-1/status)"
VGA_STATUS="$(cat /sys/class/drm/card0-VGA-1/status)"
HDMI_STATUS="$(cat /sys/class/drm/card0-HDMI-A-1/status)"

DP_ENABLED="$(cat /sys/class/drm/card0-DP-1/enabled)"
VGA_ENABLED="$(cat /sys/class/drm/card0-VGA-1/enabled)"
HDMI_ENABLED="$(cat /sys/class/drm/card0-HDMI-A-1/enabled)"

# Do no change!
EXTERNAL_DISPLAY=""
IS_ENABLED=""

# Check to see if the external display is connected
if [ "${DP_STATUS}" = connected ]; then
EXTERNAL_DISPLAY=$DP
IS_ENABLED=$DP_ENABLED
fi
if [ "${VGA_STATUS}" = connected ]; then
EXTERNAL_DISPLAY=$VGA
IS_ENABLED=$VGA_ENABLED
fi
if [ "${HDMI_STATUS}" = connected ]; then
EXTERNAL_DISPLAY=$HDMI
IS_ENABLED=$HDMI_ENABLED
fi

# The external display is connected
if [ "$EXTERNAL_DISPLAY" != "" ]; then

    # get orientation if already enabled 
    ORIENT="--right-of"
    if [ "${IS_ENABLED}" = enabled  ]; then
        if [ "$(xrandr | grep 'eDP-1' | awk -F'[ +]' '{print $6}')" -eq "0" ]; then
            ORIENT="--above"
        fi
    fi



    # Set the display settings
    xrandr --output eDP-1 --mode 1600x900 --pos 0x0 --rotate normal --primary --output "$EXTERNAL_DISPLAY" --auto $ORIENT eDP-1
    # If connected via HDMI, change the sound profile to output HDMI audio, not needed atm
    # if [ $EXTERNAL_DISPLAY=$HDMI ]; then
    # sudo -u $USER pactl set-card-profile 0 output:hdmi-surround
    # fi

# The external display is not connected
else

    # Restore to single display
    xrandr --output $EXTERNAL_DISPLAY --off

    # Restore laptop sound profile
    #sudo -u $USER pactl set-card-profile 0 output:analog-stereo+input:analog-stereo
fi
exit 0

