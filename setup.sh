#!/usr/bin/env bash

set -euo pitfail

is_installed_apt() {
    local pkg="$1"
    if dpkg -s "$pkg" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

is_installed_snap() {
    local pkg="$1"
    if snap list | grep -qw "$pkg"; then
        return 0
    else
        return 1
    fi
}

echo "Starting to setup your system..."

essentials=("git" "curl" "build-essential")
apt_packages=("python3" "bat" "clang" "clangd" "kitty")
snap_packages=("zig" "neovim")
