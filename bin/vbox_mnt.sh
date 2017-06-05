#!/bin/bash
mount -t vboxsf -o uid=1000,gid=1000 $1 /home/gym/$1
