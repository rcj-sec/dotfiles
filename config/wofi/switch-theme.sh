#!/usr/bin/env sh

argc=$#

if [[ $argc -lt 1 ]]; then
    echo "Specify a theme". 
    exit 1
fi

NEW_THEME="$1"
WOFI_CONFIG="$HOME/.config/wofi"
WOFI_THEMES="$WOFI_CONFIG/themes"
NEW_THEME_DIR="$WOFI_THEMES/$NEW_THEME"

if [ ! -d "$NEW_THEME_DIR" ]; then
    echo "[X] Bad theme configuration"
    echo "    [X] Dir not found: $NEW_THEME_DIR"
    exit 1
fi

if [[ ! -f "$NEW_THEME_DIR/drun-config" ]]; then
    echo "[X] Bad theme configuration"
    echo "    [X] File not found: $NEW_THEME_DIR/drun-config"
    exit 1
fi

if [[ ! -f "$NEW_THEME_DIR/dmenu-config" ]]; then
    echo "[X] Bad theme configuration"
    echo "    [X] File not found: $NEW_THEME_DIR/dmenu-config"
    exit 1
fi

if [[ ! -f "$NEW_THEME_DIR/drun-style.css" ]]; then
    echo "[X] Bad theme configuration"
    echo "    [X] File not found: $NEW_THEME_DIR/drun-style.css"
    exit 1
fi

if [[ ! -f "$NEW_THEME_DIR/dmenu-style.css" ]]; then
    echo "[X] Bad theme configuration"
    echo "    [X] File not found: $NEW_THEME_DIR/dmenu-style.css"
    exit 1
fi

ln -sf "themes/$NEW_THEME/drun-style.css" "$WOFI_CONFIG/"
ln -sf "themes/$NEW_THEME/drun-config" "$WOFI_CONFIG/"
ln -sf "themes/$NEW_THEME/dmenu-style.css" "$WOFI_CONFIG/"
ln -sf "themes/$NEW_THEME/dmenu-config" "$WOFI_CONFIG/"
