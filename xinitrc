#!/bin/sh

vmware-user &
xset b off
setxkbmap -layout "us,ru" -variant -option "grp:caps_toggle,grp:led_scroll,compose:ralt" &
xrdb -merge ~/.Xresources &
kbdd &
pulseaudio --start -D &
~/bin/firefox-sync &
exec awesome
