#!/bin/bash
i3-msg 'workspace "9: ☺"; append_layout ~/.config/i3/layouts/social.json'
chromium --new-window https://mail.google.com/mail/u/0/\#inbox https://spamandhex.slack.com/messages/corekor/ https://www.facebook.com/ https://twitter.com/ &
termite -e mutt &
termite -e weechat &
