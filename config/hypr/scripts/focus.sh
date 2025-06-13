#!/bin/bash
# shellcheck shell=bash

animations=$(hyprctl getoption animations:enabled | grep int)

eval set -- "$animations"

if (( $2 == 0 )); then
    echo animations are off
    hyprctl keyword animations:enabled true
    hyprctl reload
    killall -SIGUSR1 waybar
else
    echo animations are on 
    hyprctl keyword general:gaps_out 0
    hyprctl keyword decoration:rounding 0
    killall -SIGUSR1 waybar
    hyprctl keyword animations:enabled false
fi
