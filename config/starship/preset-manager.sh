#!/bin/bash

PRESETS_DIR="$HOME/.config/starship/presets"
TARGET_CONFIG="$HOME/.config/starship.toml"

if [[ $# -eq 0 ]]; then
	echo -e "\nAvailable presets:\n"
	ls "$PRESETS_DIR" | sed 's/\.toml$//'
	exit 1
fi

PRESET="$1"
SOURCE_FILE="$PRESETS_DIR/$PRESET.toml"

if [[ -f "$SOURCE_FILE" ]]; then
	cp "$SOURCE_FILE" "$TARGET_CONFIG" 
	echo "Switched to: $PRESET"
else
	echo "Preset not found: $PRESET"
	exit 2
fi
