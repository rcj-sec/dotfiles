#!/bin/bash
# shellcheck shell=bash

start() {
    main
}

main() {
    echo "Entered main"
    rofi_picker="$HOME/scripts/rofi/picker.sh"

    ssid_sec=""

    wifi_list=" Refresh"

    nmcli dev wifi rescan
    while IFS=':' read -r ssid signal security; do

        if [[ -n "$security" ]]; then 
            echo "$ssid is secure"
            ssid_sec+="$ssid\n"
        fi

        if [ "$signal" -ge 80 ]; then
            if [[ -z "$security" ]]; then 
                icon="󰤨"
            else
                icon="󰤪"
            fi
        elif [ "$signal" -ge 60 ]; then
            if [[ -z "$security" ]]; then 
                icon="󰤥"
            else
                icon="󰤧"
            fi
        elif [ "$signal" -ge 40 ]; then
            if [[ -z "$security" ]]; then 
                icon="󰤢"
            else
                icon="󰤤"
            fi
        elif [ "$signal" -ge 20 ]; then
            if [[ -z "$security" ]]; then 
                icon="󰤟"
            else
                icon="󰤡"
            fi
        else
            if [[ -z "$security" ]]; then 
                icon="󰤯"
            else
                icon="󰤬"
            fi
        fi

        wifi_list+="\n$icon $ssid"
    done < <(nmcli -t -f SSID,SIGNAL,SECURITY dev wifi list)

    echo -e "\n-------------\nssid_sec = \n$ssid_sec"

    rasi_config="$HOME/.config/rofi/wifi-dialog.rasi"
    choice=$(sh "$rofi_picker" "$wifi_list" --config "$rasi_config"| cut -d' ' -f2)
    
    if [[ -z "$choice" ]]; then
        exit 0
    elif [[ "$choice" == "Refresh" ]]; then 
        start
        exit 0
    fi

    if ! echo -e "$ssid_sec" | grep -e "^$choice$" > /dev/null; then 
        if nmcli dev wifi connect "$choice"; then
            kitten notify -e 2s "$choice" "Successfully connected!"
        else
            kitten notify -e 2s "$choice" "Failed to connect." 
        fi
        exit 0
    fi

    echo "$choice"

    if nmcli -f NAME con show | grep -e "^$choice$" > /dev/null; then
        if nmcli dev wifi connect "$choice"; then
            kitten notify -e 2s "$choice" "Successfully connected!" 
            exit 0
        else
            nmcli con del "$choice"
        fi
    fi


    rofi_config="$HOME/.config/rofi"
    password=$(rofi -dmenu  -config  "$rofi_config/password-wifi.rasi" -password)

    if [[ -z "$password" ]]; then
        start
        exit 0
    fi

    if nmcli dev wifi connect "$choice" password "$password"; then
        kitten notify -e 2s "$choice" "Successfully connected!" 
        exit 0
    else
        nmcli con del "$choice"
        start
        exit 0
    fi
}

start






























