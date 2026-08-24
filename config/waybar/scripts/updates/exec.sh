#!/usr/bin/env bash

CACHE_FILE="$HOME/.cache/updates"
UPDATE_SCRIPT="$HOME/scripts/check-updates.sh"

sh "$UPDATE_SCRIPT" --notify
cat "$CACHE_FILE"

