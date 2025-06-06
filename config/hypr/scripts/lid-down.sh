#!/bin/bash

connected=$(hyprctl monitors | grep -v "eDP" | grep -c "Monitor")

if [ "$connected" -eq 0 ]; then
    # No external monitor, shutdown system
    systemctl poweroff
else
    # External monitor detected, disable built-in screen
    hyprctl keyword monitor "eDP-1, disable"
fi
