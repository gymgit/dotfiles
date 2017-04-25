#!/bin/bash

append_conf() {
    if [[ "$DEBUG" -eq "1" ]]; then
        echo "[DBG] writing $2"
        echo $1
        echo "[DBG/]"
    else
        echo $1 | $SUDO tee -a $2
    fi
}

## config ntp and time
TXT='[Time]
NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 0.fr.pool.ntp.org'
append_conf $TXT "/etc/systemd/timesyncd.conf"
## enable ntp
timedatectl set-ntp true 
# set system clock (if needed)
#hwclock --systohc

# auto join nw
# dependency: netctl (part of base), wpa_supplicant, dhcpcd, dialog
# wireless, dep: wpa_actiond
# $SUDO systemctl start/enable netctl-auto@interface.service
# wired, dep: ifplugd
# $SUDO systemctl start/enable netctl-ifplugd@interface.service

#powersettings
# hibernate on power button
# do not suspend on lid switch
TXT='
HandlePowerKey=hibernate
HandleLidSwitch=ignore'
append_conf $TXT "/etc/systemd/login.conf"

# TODO lock on lid close
# ?? systemd hook
# set up lock on suspend/hibernate/sleep/monitor off
# see systemd hooks
#https://wiki.archlinux.org/index.php/Power_management#Sleep_hooks
