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
    echo "Usage: $0 1h 20m 40s"
    exit 1
fi;

echo "[+] Setting timer for $arguments"
echo "[+] Total seconds: $total_seconds"

noti_id=$(notify-send "Timer set for $arguments" "Time is ticking..." -p)

sleep "$total_seconds"

notify-send "Time is up" "Your timer has finished." -u critical -r "$noti_id"

if command -v paplay &> /dev/null; then 
    paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga &
fi
