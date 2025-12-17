#!/usr/bin/env bash

input="$1"

hours="${input%%:*}"
minutes="${input##*:}"

# Store in variable in HHh MMm format
human_time="${hours}h ${minutes}m"

mpv --loop  --no-video --volume=130 /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga &
MPV_PID==$!

trap "kill $MPV_PID 2>/dev/null" EXIT

notify-send "Alarm $human_time" "It is time." -u critical -w

systemctl --user stop alarm@${1}.timer
