#!/bin/bash

exec="$HOME/.config/waybar/modules/battery/exec.sh"
link=$(readlink  "$exec")

if [[ "$link" == "display-alt.sh" ]]; then
    ln -sf "display.sh" "$exec"
elif [[ "$link" == "display.sh" ]]; then
    ln -sf "display-alt.sh" "$exec"
fi

pkill -SIGRTMIN+10 waybar

