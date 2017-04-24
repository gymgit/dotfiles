#!/bin/bash
remote_id=$(
  xinput list |
  sed -n 's/.*Naga.*id=\([0-9]*\).*keyboard.*/\1/p'
)
[ "$remote_id" ] || exit

mkdir -p /tmp/xkb/symbols
cat >/tmp/xkb/symbols/custom <<\EOF
xkb_symbols "remote" {
    key <AE01>   { [F1, F1] };
    key <AE02>   { [F2, F2] };
    key <AE03>   { [F3, F3] };
    key <AE04>   { [F4, F4] };
    key <AE05>   { [F5, F5] };
    key <AE06>   { [F6, F6] };
    key <AE07>   { [7, 7] };
    key <AE08>   { [8, 8] };
    key <AE09>   { [9, 9] };
    key <AE10>   { [F10, F10] };
    key <AE11>   { [F11, F11] };
    key <AE12>   { [F12, F12] };
};
EOF

setxkbmap -device $remote_id -print | sed 's/\(xkb_symbols.*\)"/\1+custom(remote)"/' | xkbcomp -I/tmp/xkb -i $remote_id -synch - $DISPLAY 2>/dev/null
