#!/bin/bash

# Manage the PATH variable with ease
# Automatically updates profile file (only bashrc or zshrc)

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
            echo "export PATH=\"\$PATH:$shell_safe_path\"" >> "$SHELL_RC"
            export PATH="$PATH:$absolute_path"
        else
            echo "$absolute_path already in PATH"
        fi
    ;;

    remove)
        export PATH=$(echo "$PATH" | sed -E "s;(:|^)${absolute_path}(:|$);:;g" | sed -E 's;^:;;' | sed -E 's;:$; ;')
        sed -i "/^export PATH=\"\$PATH:${shell_safe_path//\//\\/}\"$/d" $SHELL_RC
        echo "Removed $absolute_path from PATH"
    ;;

    help|*)
        echo -e "\nManage the PATH variable. Updates the environment vairable and the profile file."
        echo
        echo "Usage:"
        echo "  pathifier list                 # Show current PATH"
        echo "  pathifier add                  # Add current path"
        echo "  pathifier add /your/path       # Add a path"
        echo "  pathifier remove /your/path    # Remove a path"
        echo
    ;;
esac
