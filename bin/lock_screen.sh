#!/usr/bin/env bash

# requires i3 lock color
lsteel=9da3afff

insidecolor=00000000
ringcolor=$lsteel
keyhlcolor=d23c3dff
bshlcolor=d23c3dff
separatorcolor=00000000
insidevercolor=00000000
insidewrongcolor=d23c3dff
ringvercolor=$lsteel
ringwrongcolor=b3c0ccff
verifcolor=b3c0ccff
timecolor=b3c0ccff
datecolor=b3c0ccff
loginbox=00000066
font="sans-serif"
locktext='Type password to unlock...'

i3lock \
		-B 5 \
		--time-pos='x+110:h-70' \
		--date-pos='x+43:h-45' \
		--clock --date-align 1 --date-str "$locktext" \
		--inside-color=$insidecolor --ring-color=$ringcolor --line-uses-inside \
		--keyhl-color=$keyhlcolor --bshl-color=$bshlcolor --separator-color=$separatorcolor \
		--insidever-color=$insidevercolor --insidewrong-color=$insidewrongcolor \
		--ringver-color=$ringvercolor --ringwrong-color=$ringwrongcolor --ind-pos='x+280:h-70' \
		--radius=20 --ring-width=4 --verif-text='' --wrong-text='' \
		--verif-color="$verifcolor" --time-color="$timecolor" --date-color="$datecolor" \
		--time-font="$font" --date-font="$font" --layout-font="$font" --verif-font="$font" --wrong-font="$font" \
		--noinput-text='' --force-clock
