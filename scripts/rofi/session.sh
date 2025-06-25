#!/bin/bash
# shellcheck shell=bash

shutdown="  Shutdown"
lock="󰌾  Lock"
sleep="󰒲  Sleep"
reboot="  Restart"

modes="$shutdown\n$lock\n$reboot\n$sleep"
picker="$HOME/scripts/rofi/picker.sh"

choice=$(sh "$picker" "$modes")

case "$choice" in
"$shutdown")
	systemctl poweroff 
	;;
"$lock")
    hyprlock
    ;;
"$sleep")
    echo Zzzz
    ;;
"$reboot")
    systemctl reboot
    ;;
esac
