#!/bin/sh

hyprshot -s --clipboard-only -m region

kitty -e bash -c "nvim $HOME/Pictures"
