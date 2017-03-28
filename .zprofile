#!/bin/bash

# load the .profile en emulation mode

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
