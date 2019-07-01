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
		--timepos='x+110:h-70' \
		--datepos='x+43:h-45' \
		--clock --date-align 1 --datestr "$locktext" \
		--insidecolor=$insidecolor --ringcolor=$ringcolor --line-uses-inside \
		--keyhlcolor=$keyhlcolor --bshlcolor=$bshlcolor --separatorcolor=$separatorcolor \
		--insidevercolor=$insidevercolor --insidewrongcolor=$insidewrongcolor \
		--ringvercolor=$ringvercolor --ringwrongcolor=$ringwrongcolor --indpos='x+280:h-70' \
		--radius=20 --ring-width=4 --veriftext='' --wrongtext='' \
		--verifcolor="$verifcolor" --timecolor="$timecolor" --datecolor="$datecolor" \
		--time-font="$font" --date-font="$font" --layout-font="$font" --verif-font="$font" --wrong-font="$font" \
		--noinputtext='' --force-clock
