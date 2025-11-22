#!/bin/sh

xrandr --output DVI-D-0 --right-of DP-0
xrandr --output HDMI-0 --right-of DVI-D-0

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

feh --no-fehbg --bg-scale '/home/alex/.config/wallpapers/topography.png' &
exec i3
