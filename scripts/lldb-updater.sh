#!/bin/bash

LLVM_MIRROR="https://apt.llvm.org"
TMPFILE=$(mktemp)

function usage() {
    echo -e "\nCheck for updates and update your lldb toolchain, including lldb-dap."
    echo -e "\nUsage:"
    echo "  lldb-updater update             # Check for newer LLVM versions"
    echo "  lldb-updater update <version>   # Install specified LLVM version and link lldb-dap"
    echo
    exit 1
}

function is_version_released() {
    local ver=$1
    curl -sfI "https://apt.llvm.org/pool/main/l/llvm-toolchain-$ver/lldb-$ver_*.deb" >/dev/null
}

function check_updates() {
    echo "🔍 Checking available LLVM versions..."
    curl -s ${LLVM_MIRROR}/ | grep -oP 'llvm-\K[0-9]+' | sort -un> $TMPFILE
    CURRENT=$(ls /usr/lib | grep -oP '^llvm-\K[0-9]+' | sort -un | tail -n1)

    echo "✅ Installed LLVM version: ${CURRENT:-none}"
    echo "📦 Available versions:"
    cat $TMPFILE | while read -r v; do
        if [[ "$v" -gt "$CURRENT" ]]; then
            echo "  → $v (update available)"
        else
            echo "  - $v"
        fi
    done
}

function install_version() {
    VERSION="$1"
    echo "📥 Installing LLVM version $VERSION..."
    wget -q https://apt.llvm.org/llvm.sh -O llvm.sh
    chmod +x llvm.sh
    sudo ./llvm.sh "$VERSION"

    LLDB_DAP_PAT="/usr/lib/llvm-$VERSION/bin/lldb-dap"
    if [[ -f "$LLDB_DAP_PATH" ]]; then
        echo "🔗 Linking lldb-dap to /usr/bin..."
        sudo ln -sf "$LLDB_DAP_PATH" /usr/bin/lldb-dap
        echo "✅ lldb-dap $VERSION is now available at /usr/bin/lldb-dap"
    else
        echo "❌ lldb-dap not found at expected path. Installation may have failed."
    fi
    rm -f llvm.sh
}

# Main logic
if [[ "$1" == "update" ]]; then
    if [[ -z "$2" ]]; then
        check_updates
    else
        install_version "$2"
    fi
else
    usage
fi

