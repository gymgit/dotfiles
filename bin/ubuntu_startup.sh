#!/bin/bash
# this used to be in rc.local now it is executed by systemd

mount -t vboxsf -o uid=1000,gid=1000 dwnload /home/gym/dwnload
mount -t vboxsf -o uid=1000,gid=1000 dev /home/gym/dev
# this could be made permanent but w/e
echo 0 > /proc/sys/kernel/yama/ptrace_scope

