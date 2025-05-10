#!/bin/bash

# Detect shell rc file
SHELL_RC="$HOME/.bashrc"
[[ $SHELL =~ zsh ]] && SHELL_RC="${ZDOTDIR:-$HOME}/.zshrc"

# Normalize path: strip trailing slash unless it's root "/"
target_path="${2:-$PWD}"
absolute_path="$(realpath -m "$target_path")"
shell_safe_path=$absolute_path
if [[ "$absolute_path" == "$HOME"* ]]; then
    shell_safe_path="\$HOME${absolute_path#$HOME}"
fi

case "$1" in
    list)
        echo "$PATH" | tr ':' '\n'
    ;;

    add)
        if [[ ":$PATH:" != *":$absolute_path:"* ]]; then
            echo "Adding $absolute_path to PATH"
            echo "export PATH=\"$shell_safe_path:\$PATH\"" >> "$SHELL_RC"
            export PATH="$absolute_path:$PATH"
        else
            echo "$clean_path already in PATH"
        fi
    ;;

    remove)
        export PATH=$(echo "$PATH" | awk -v RS=: -v ORS=: '$0 != "'"$absolute_path"'"' | sed 's/:$//')
        sed -i "\|export PATH=\"$shell_safe_path:\\\$PATH\"|d" "$SHELL_RC"
        echo "Removed $absolute_path from PATH"
    ;;

    help|*)
        echo "Usage:"
        echo "  pathifier list                 # Show current PATH"
        echo "  pathifier add                  # Add current path"
        echo "  pathifier add /your/path       # Add a path"
        echo "  pathifier remove /your/path    # Remove a path"
    ;;
esac
