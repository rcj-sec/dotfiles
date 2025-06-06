#!/bin/bash

wifi_status=$(nmcli radio wifi)
if [[ "$wifi_status" == "enabled" ]]; then
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
else
    eth_status=$(nmcli -t -f DEVICE,TYPE,STATE device | grep '^.*:ethernet:connected$')
    if (( $? == 0)); then
        interface=$(echo "$eth_status" | awk '{print $1}')
        echo "󱘖 $interface"
        exit 0
    fi
fi
echo "Not connected"
