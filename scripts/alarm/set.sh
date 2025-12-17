#!/usr/bin/env bash

if [[ -z "$1" ]]; then 
    notify-send "Bad usage" "alarm HH [mm]" -u low
    exit 1
fi

hours="$1"
minutes="${2:-0}"


# Validate inputs
if ! [[ "$hours" =~ ^[0-9]+$ ]] || (( hours < 0 || hours > 23 )); then
    notify-send "Bad usage" "alarm HH [mm]" -u low
    exit 1
fi

if ! [[ "$minutes" =~ ^[0-9]+$ ]] || (( minutes < 0 || minutes > 59 )); then
    notify-send "Bad usage" "alarm HH [mm]" -u low
    exit 1
fi

alarm_time=$(printf "%02d:%02d" "$hours" "$minutes")

notify-send "Alarm set for ${hours}h ${minutes}m" "Arch will let you know..." -e

systemctl --user start alarm@${alarm_time}.timer

