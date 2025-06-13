#!/bin/bash

mode=$(powerprofilesctl get)

output="$mode"

case "$mode" in
    "performance")
        output="  Full"
        ;;
    "balanced")
        output="  Bal"
        ;;
    "power-saver")
        output="󰌪  Eco"
        ;;
esac


echo "$output"


