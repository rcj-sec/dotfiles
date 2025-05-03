#!/bin/bash

# Detect shell rc file
SHELL_RC="$HOME/.bashrc"
[[ $SHELL =~ zsh ]] && SHELL_RC="${ZDOTDIR:-$HOME}/.zshrc"

# Normalize path: strip trailing slash unless it's root "/"
normalize_path() {
  local path="$1"
  [[ "$path" == "/" ]] && echo "/" || echo "${path%/}"
}

case "$1" in
  list)
    echo "$PATH" | tr ':' '\n'
    ;;

  add)
    target_path="${2:-$PWD}"

    clean_path=$(normalize_path "$target_path")

    if [[ ":$PATH:" != *":$clean_path:"* ]]; then
      echo "Adding $clean_path to PATH"
      echo "export PATH=\"$clean_path:\$PATH\"" >> "$SHELL_RC"
      export PATH="$clean_path:$PATH"
    else
      echo "$clean_path already in PATH"
    fi
    ;;

  remove)
    target_path="${2:-$PWD}"

    clean_path=$(normalize_path "$target_path")

    # Update PATH in current session
    export PATH=$(echo "$PATH" | awk -v RS=: -v ORS=: '$0 != "'"$clean_path"'"' | sed 's/:$//')

    # Remove the line from the shell rc file
    sed -i "\|export PATH=\"$clean_path:\\\$PATH\"|d" "$SHELL_RC"

    echo "Removed $clean_path from PATH"
    ;;

  help|*)
    echo "Usage:"
    echo "  pathifier list                 # Show current PATH"
    echo "  pathifier add                  # Add current path"
    echo "  pathifier add /your/path       # Add a path"
    echo "  pathifier remove /your/path    # Remove a path"
    ;;
esac
