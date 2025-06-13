#!/bin/sh
# shellcheck shell=bash
output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
if [[ -z "$output" ]]; then
    sleep 2
    output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
fi

echo "output     $output" >> /home/zeroday/logsound.txt

volume_raw=$(echo "$output" | cut -d' ' -f2)
volume=$(echo "$output" | cut -d'.' -f2) 

echo "volume raw $volume_raw" >> /home/zeroday/logsound.txt
echo "volum      $volume"     >> /home/zeroday/logsound.txt

if echo "$output" | grep "[MUTED]" > /dev/null; then
    echo " 󰖁 "
elif [[ "$volume_raw" == "1.00" ]]; then
    echo "100 󰕾"
elif [[ "$volume_raw" == "0.00" ]]; then
    echo " 󰖁 "
elif (( volume < 50 )); then
    echo "󰖀 $volume"
else
    echo "󰕾 $volume"
fi 
