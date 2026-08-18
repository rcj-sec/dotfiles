#!/usr/bin/sh bash

CACHE_FILE="$HOME/.cache/updates"

notify=false 
update_waybar=false

for arg in "$@"; do 
    case "$arg" in
        --notify)
            notify=true 
            ;;
        --update-waybar)
            update_waybar=true 
            ;;
    esac
done

pacman_updates=$(checkupdates | wc -l)
yay_updates=$(aur-check-updates --raw | wc -l)
total_updates=$(( pacman_updates + yay_updates))

text=" $total_updates"
tooltip="<b>pacman:</b> $pacman_updates \n<b>yay:</b> $yay_updates"
echo "{ \"text\": \"$text\", \"tooltip\": \"$tooltip\" }" > "$CACHE_FILE"

if $update_waybar; then 
    pkill -RTMIN+8 waybar
fi


if $notify && [[ $total_updates -gt 0 ]]; then
    HINT_UPDATES="string:x-canonical-private-synchronous:updates"
    TITLE="Pending updates"
    BODY="$tooltip"
    notify-send --hint="$HINT_UPDATES" "$TITLE" "$BODY" -i system -a System
fi
