#!/bin/bash

target_path="${1:-$PWD}"
absolute_path="$(realpath -m "$target_path")"
shell_safe_path=$absolute_path
if [[ "$absolute_path" == "$HOME"* ]]; then
    shell_safe_path="\$HOME${absolute_path#$HOME}"
fi
echo Absolute path:      $absolute_path
echo Shell safe path:    $shell_safe_path