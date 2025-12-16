#!/usr/bin/sh

# Input: total seconds
total_seconds=$1

# Calculate hours, minutes, seconds
hours=$(( total_seconds / 3600 ))
minutes=$(( (total_seconds % 3600) / 60 ))
seconds=$(( total_seconds % 60 ))

output=""
[[ $hours -gt 0 ]] && output+="${hours}h "
[[ $minutes -gt 0 ]] && output+="${minutes}m "
[[ $seconds -gt 0 || -z "$output" ]] && output+="${seconds}s"

notify-send "Time is up" "Time passed: $output"
systemctl --user stop timer@${total_seconds}.timer
