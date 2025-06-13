#!/bin/bash

zone=$(firewall-cmd --get-default-zone)

icons="$HOME/.icons/svg"

sudo -K

export SUDO_ASKPASS="$HOME/scripts/rofi/root-prompt.sh"

if [[ "$zone" == "public" ]]; then
    next=block
elif [[ "$zone" == "block" ]]; then
    next=public
else
    next=block
fi

if sudo -A firewall-cmd --set-default-zone="$next"; then
    notify-send "Firewall change to $next" -i "$icons/ok.svg" -t 2000
else
    notify-send "Could not change to $next" -i "$icons/error.svg" -t 2000
fi


pkill -RTMIN+8 waybar 

