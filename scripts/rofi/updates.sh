#!/bin/bash
# shellcheck shell=bash

icons="$HOME/.icons/svg"

start() {
    main
}

main() {
    echo -e "$info"
    updates=$(echo -e "$info" | awk '{printf " %s\n", $1}')
    updates="  All\n$updates"
    rofi_picker="$HOME/scripts/rofi/picker.sh"

    choice=$(sh "$rofi_picker" "$updates" -scroll-method 1| awk '{print $2}')
    if [[ -z "$choice" ]]; then 
        exit 0
    elif [[ "$choice" == "All" ]]; then 
        if kitty -e bash -c "yay -Syu"; then
            notify-send "System udpated!" -i "$icons/ok.svg" -t 2000
        fi
        exit
    fi
    
    versions=$(echo -e "$info" | grep -e "^$choice " | awk  '{printf "%s -> %s", $2, $3}')
    choice1=$(sh "$rofi_picker" "Update\nBack" -mesg "$versions")
    
    if [[ -z "$choice1" ]]; then 
        exit 0
    elif [[ "$choice1" == "Update" ]]; then
        if kitty -e bash -c "yay -S $choice"; then 
            notify-send "Updated: $choice" -i "$icons/ok.svg" -t 2000
        fi
    else
        start
    fi
}

sudo -K

export SUDO_ASKPASS="$HOME/scripts/rofi/root-prompt.sh"

yay -Sy

if ! info=$(yay -Qu); then
    notify-send "System up to date!" -i "$icons/ok.svg" -t 2000
    exit 0
fi

info=$(echo -e "$info" | awk '{printf "%s %s %s\n", $1, $2, $4}')

start
