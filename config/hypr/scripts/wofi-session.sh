#!/usr/bin/env sh

printf "󰐥 Shutdown\n Reboot\n Lock\n Log out" | wofi --dmenu --hide-search --no-custom-entry -c ~/.config/wofi/drun-config -H 200  --sort-order=ALPHABETICAL
