#!/bin/bash
# shellcheck shell=bash

modes="  Performance\n  Balanced\n󰌪  Power-saver"
picker="$HOME/scripts/rofi/picker.sh"

choice=$(sh "$picker" "$modes" | awk '{print $2}')

if [[ -z "$choice" ]]; then
    exit 0
fi
echo "${choice,,}"

powerprofilesctl set "${choice,,}"

