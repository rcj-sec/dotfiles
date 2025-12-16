#!/usr/bin/env bash

total_seconds=0
arguments=$@

for arg in "$@"; do
    case "$arg" in
        *h) hours=${arg%h}; total_seconds=$((total_seconds + hours*3600)) ;;
        *m) minutes=${arg%m}; total_seconds=$((total_seconds + minutes*60)) ;;
        *s) seconds=${arg%s}; total_seconds=$((total_seconds + seconds)) ;;
        *)
            total_seconds=$((total_seconds + arg))
            arguments+=s
        ;;
    esac
done

if [ "$total_seconds" -le 0 ]; then
    notify-send "Bad usage: timer" "Example: timer 60m"
    exit 1
fi;

notify-send "Timer set for $arguments" "Time is ticking..."
echo "set timer for $arguments"

systemctl --user start timer@${total_seconds}.timer
