#!/bin/bash

wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz
tar xf afl-latest.tgz
cd afl-*b
make
mkvirtualenv -p /usr/bin/python2.7 def2 # or workon def2
cd qemu-mode
./build_qemu_support.sh
