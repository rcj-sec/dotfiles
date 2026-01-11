#!/usr/bin/env sh

argc=$#

if [[ $argc -lt 1 ]]; then
    echo "You must indicate a theme"
    exit 1
fi

NEW_THEME="$1"
WAYBAR_CONFIG="$HOME/.config/waybar"
WAYBAR_THEMES="$WAYBAR_CONFIG/themes"
NEW_THEME_DIR="$WAYBAR_THEMES/$NEW_THEME"

if [ ! -d "$NEW_THEME_DIR" ]; then 
    echo "[X] Theme does not exist: $NEW_THEME" 
    echo "    [X] Directory not found: $NEW_THEME_DIR"
    exit 1
fi

NEW_THEME_CONFIG="$NEW_THEME_DIR/config.jsonc"
NEW_THEME_STYLE="$NEW_THEME_DIR/style.css"

if [[ ! -f "$NEW_THEME_CONFIG" ]]; then
    echo "[X] Theme config not found"
    echo "    [X] File not found: $NEW_THEME_CONFIG"
    exit 1
fi

if [[ ! -f "$NEW_THEME_STYLE" ]]; then
    echo "[X] Theme style not found"
    echo "    [X] File not found: $NEW_THEME_STYLE"
    exit 1
fi


ln -sf "themes/$NEW_THEME/config.jsonc" "$WAYBAR_CONFIG/config.jsonc"
ln -sf "themes/$NEW_THEME/style.css" "$WAYBAR_CONFIG/style.css"

systemctl --user restart waybar
