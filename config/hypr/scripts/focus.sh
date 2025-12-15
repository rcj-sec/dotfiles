#!/bin/bash
# shellcheck shell=bash
focus=$(hyprctl getoption general:gaps_in | awk 'NR==1{print $3}')

echo $focus



if (( $focus != 2 )); then
    hyprctl keyword decoration:shadow:enabled false
    hyprctl keyword general:gaps_out 0,0,0,0
    hyprctl keyword general:gaps_in  2
    killall -SIGUSR1 waybar
else
    killall -SIGUSR1 waybar
    hyprctl reload
fi
