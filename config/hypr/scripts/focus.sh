#!/bin/bash
# shellcheck shell=bash

focus=$(hyprctl getoption general:gaps_out | awk 'NR==1{print $3}')

echo $focus


if (( $focus > 0 )); then
    killall -SIGUSR1 waybar
    hyprctl keyword general:gaps_out 0
    hyprctl keyword general:gaps_in  2
    hyprctl keyword decoration:rounding 0
else
    killall -SIGUSR1 waybar
    hyprctl reload
fi
