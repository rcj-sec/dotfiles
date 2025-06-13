#!/bin/bash

BAT_PATH="/sys/class/power_supply/BAT1"
AC_PATH="/sys/class/power_supply/ADP1"

# Read values
capacity=$(cat "$BAT_PATH/capacity")
charging=$(cat "$AC_PATH/online")

declare -A icons=(
    [5]="󰂎"
    [10]="󰁺"
    [20]="󰁻"
    [30]="󰁼"
    [40]="󰁽"
    [50]="󰁾"
    [60]="󰁿"
    [70]="󰂀"
    [80]="󰂁"
    [90]="󰂂"
    [100]="󰁹"
)
icon="󰁹"  # default icon
for percent in $(printf "%s\n" "${!icons[@]}" | sort -n); do
    if (( capacity <= percent )); then
        icon="${icons[$percent]}"
        break
    fi
done

if [[ "$charging" == "1" ]]; then
    echo "󱐋$icon $capacity%"
else
    echo " $icon $capacity%"
fi
