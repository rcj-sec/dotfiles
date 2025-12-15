#!/usr/bin/env bash
notify-send "  Time is up" "Your timer has finished." -u critical

if command -v paplay &> /dev/null; then 
    paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga &
fi
