#!/usr/bin/env sh 

argc=$#

if [[ $argc -lt 1 ]]; then
    echo "You must indicate a theme"
    exit 1
fi

NEW_THEME="$1"
HYPR_CONFIG="$HOME/.config/hypr"
HYPR_THEMES="$HYPR_CONFIG/themes"
NEW_THEME_DIR="$HYPR_THEMES/$NEW_THEME"

if [ ! -d "$NEW_THEME_DIR" ]; then 
    echo "[X] Theme does not exist: $NEW_THEME" 
    echo "    [X] Directory not found: $NEW_THEME_DIR"
    exit 1
fi

NEW_THEME_CONFIG="$NEW_THEME_DIR/hyprland.conf"

if [[ ! -f "$NEW_THEME_CONFIG" ]]; then
    echo "[X] Theme config not found"
    echo "    [X] File not found: $NEW_THEME_CONFIG"
    exit 1
fi

ln -sf "themes/$NEW_THEME/hyprland.conf" "$HYPR_CONFIG/"

