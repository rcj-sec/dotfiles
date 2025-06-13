#!/bin/bash

ssid=$(nmcli -t -f STATE,CONNECTION dev status | grep -e "^connected:" | cut -d':' -f2)

if [[ -n "$ssid" ]]; then
    nmcli con down "$ssid" && nmcli con up "$ssid"
fi
