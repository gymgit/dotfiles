#!/bin/bash
#only do this if not exists
#cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
#curl -o /etc/pacman.d/mirrorlist.fresh https://www.archlinux.org/mirrorlist/all/
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 7 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
# /etc/pacman.conf
[archlinuxfr]
SigLevel = never
Server = http://repo.archlinux.fr/$arch
pacman -S yaourt

### uncomment multilib atc pacman.conf
