#!/bin/bash

# vbox uses the net-tools to configure the host only interface host side
pacman -S net-tools
# mount as correct owner
mount -t vboxsf -o uid=1000,gid=1000 $sharename /path
