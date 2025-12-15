#!/usr/bin/sh

set -f

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
        notify-send "Error" "Command failed (exit $status)"
    fi
    ;;
esac

case "$input" in
  *[\;\|\&\>\<\`\$]*)
    notify-send "Blocked shell syntax" "$input" -u critical -t 1000
    exit 1
    ;;
esac

#Split arguments safely (no eval, no shell parsing)
set -- $input

# Execute directly
"$@"
status=$?

if [ "$status" -eq 0 ]; then
    notify-send "Success" "Command exited successfully"
else
    notify-send "Error" "Command failed (exit $status)"
fi
