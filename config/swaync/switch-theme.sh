#!/usr/bin/env sh

argc=$#

if [ $argc -lt 1 ]; then 
    echo "Specify a theme"
    exit 1
fi

SWAYNC_CONFIG="$HOME/.config/swaync"
SWAYNC_THEMES="$SWAYNC_CONFIG/themes" 
TARGET_THEME_NAME="$1" 
TARGET_THEME_DIR="$SWAYNC_THEMES/$TARGET_THEME_NAME"

if [[ ! -d "$TARGET_THEME_DIR" ]]; then
    echo "[X] Theme configuration does not exist."
    echo "    [X] Dir not found: $TARGET_THEME_DIR"
    exit 1
fi

if [[ ! -f "$TARGET_THEME_DIR/config.json" ]]; then
    echo "[X] Theme configuration does not exist."
    echo "    [X] File not found: $TARGET_THEME_DIR/config.json"
    exit 1
fi

if [[ ! -f "$TARGET_THEME_DIR/style.css" ]]; then
    echo "[X] Theme configuration does not exist."
    echo "    [X] File not found: $TARGET_THEME_DIR/style.css"
    exit 1
fi

ln -sf "themes/$TARGET_THEME_NAME/config.json" "$SWAYNC_CONFIG/config.json"
ln -sf "themes/$TARGET_THEME_NAME/style.css" "$SWAYNC_CONFIG/style.css"

swaync-client -rs -R
