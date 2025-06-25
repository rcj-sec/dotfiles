#!/bin/bash

items=$1
shift 1

num_lines=$(echo -e "$items" | wc -l)
if (( num_lines > 10 )); then
    num_lines=10;
fi

config_file="$HOME/.config/rofi/dialog.rasi"

rofi_args=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        --config)
            shift
            if [[ -n "$1" ]]; then 
                config_file="$1"
                shift
            else
                echo "Error: --config requires a file path"
                exit 1
            fi
            ;;
        *)
            rofi_args+=("$1")
            shift
            ;;
    esac
done



echo -e "$items" | rofi -dmenu -config "$config_file" -monitor -3 -click-to-exit -hover-select -i -l "$num_lines" "${rofi_args[@]}"
