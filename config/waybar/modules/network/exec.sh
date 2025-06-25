#!/bin/bash

device_status=$(nmcli -t -f DEVICE,TYPE,STATE device)

interface=$(echo "$device_status" | grep -e "^.*:ethernet:connected$" | awk -F: '{print $1}')

if echo "$device_status" | grep -e "^.*:wifi:connected$" > /dev/null; then
    connected_to=$(nmcli -f ACTIVE,SSID,SIGNAL dev wifi | awk '$1 == "yes"{print}')
    signal=0
    if [[ -n "$connected_to" ]]; then
        signal=$(echo "$connected_to" | awk '{print $3}')
        ssid=$(echo "$connected_to" | awk '{print $2}')

        if (( signal >= 75 )); then
            glyph="󰤨"  # strongest
        elif (( signal >= 50 )); then
            glyph="󰤥"
        elif (( signal >= 25 )); then
            glyph="󰤢"
        else
            glyph="󰤟"  # weakest
        fi

        echo "$glyph $ssid"
        exit 0
    fi
elif [[ -n "$interface" ]]; then
    echo "󱘖 $interface"
    exit 0
fi
echo "Not connected"
