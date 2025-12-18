#!/usr/bin/env sh

set -f

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin"

input=$(wofi --dmenu -c ~/.config/wofi/dmenu-config 2> /dev/null) || exit 1;
input=$(printf '%s' "$input" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

[ -z "$input" ] && exit 0

case "$input" in
  \!*)
    sh -c "${input#\!}"
    status=$?

    if [ "$status" -eq 0 ]; then
        notify-send "Success" "Command exited successfully"
    else
        notify-send "Error" "Command failed (exit $status)" -u low
    fi
    ;;
esac

case "$input" in
  *[\;\|\&\>\<\`\$]*)
    notify-send "Blocked shell syntax" "$input" -u critical
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
    notify-send "Error" "Command failed (exit $status)" -u low -t 3000
fi
