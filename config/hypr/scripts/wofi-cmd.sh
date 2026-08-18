#!/usr/bin/env sh

set -f

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin"

input=$(wofi --show dmenu -c ~/.config/wofi/dmenu-config);
input=$(printf '%s' "$input" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

echo $input

case "$input" in
  *[\;\|\&\>\<\`\$]*)
    notify-send "Blocked shell syntax" "$input" -u critical -a system
    exit 1
    ;;
esac

#Split arguments safely (no eval, no shell parsing)
set -- $input

echo Executing "$@"

# Execute directly
"$@"
status=$?

if [ "$status" -ne 0 ]; then
    notify-send "Error" "Command failed (exit $status)" -u low -a system
fi
