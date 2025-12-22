#!/usr/bin/env sh


hyprcap shot region -c -N > /dev/null || exit 1;


HYPRCAP_CACHE="$HOME/.cache/hyprcap/"
SCREENSHOT_CACHED_FILE="${HYPRCAP_CACHE}/capture.png"

noti_outcome=$(notify-send "Screenshot taken" "Click on this notification to open it." \
    -i "$SCREENSHOT_CACHED_FILE" \
    -w -t 5000 \
    -c screenshot)

if (( noti_outcome ==1 )); then 
    eog "$SCREENSHOT_CACHED_FILE"
fi


