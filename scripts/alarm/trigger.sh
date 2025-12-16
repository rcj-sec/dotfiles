#!/usr/bin/env bash

input="$1"

hours="${input%%:*}"
minutes="${input##*:}"

# Store in variable in HHh MMm format
human_time="${hours}h ${minutes}m"

notify-send "Alarm $human_time" "It is time." -u critical

systemctl --user stop alarm@${1}.timer
