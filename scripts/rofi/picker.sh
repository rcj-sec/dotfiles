#!/bin/bash

items=$1
num_lines=$(echo -e "$items" | wc -l)
if (( num_lines > 10 )); then
    num_lines=10;
fi
config_file="$HOME/.config/rofi/dialog.rasi"
echo -e "$items" | rofi -dmenu -click-to-exit -hover-select -i -l "$num_lines"  -config "$config_file" "$@"
