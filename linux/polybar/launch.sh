#!/bin/bash
killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # TODO: Only launch 1 bar with system tray
    MONITOR=$m polybar --reload default &
  done
else
  polybar --reload default &
fi
