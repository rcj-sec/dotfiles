#!/bin/bash

set -e

SSH_DIR="$HOME/.ssh"
SSH_CONFIG="$SSH_DIR/config"

create_key() {
    local alias="$1"
    local user="$2"
    local comment="$3"
    local key_path="$SSH_DIR/id_ed25519_$alias"
    
    if [[ -f "$key_path" || -f "$key_path.pub" ]]; then 
	echo "❌ Key with alias '$alias' already exists at $key_path"
	exit 1
    fi

    echo "⌛Creating SSH key with alias '$alias' and comment '$comment'..."
    ssh-keygen -t ed25519 -C "$comment" -f "$key_path"

    echo echo "⌛Adding to ssh-agent..."

    eval "$(ssh-agent -s)" > /dev/null
    ssh-add "$key_path"

    echo echo "⌛Updating SSH config..."

    echo $user $alias

    {
	echo ""
	echo "Host $alias"
	echo "    HostName $alias.com"
	echo "    User $user"
	echo "    IdentityFile $key_path"
	echo "    IdentitiesOnly yes"
    } >> "$SSH_CONFIG"

    chmod 600 "$SSH_CONFIG"
    echo "✅ Key created and SSH config updated."
    wl-copy < "$key_path.pub"
    echo "✅ Key copied to your clipboard. Your key is:"
    echo
    wl-paste
}

remove_key() {
    local alias="$1"
    local key_path="$SSH_DIR/id_ed25519_$alias"

    if [[ ! -f "$key_path" && ! -f "$key_path.pub" ]]; then
	echo "❌ No key found for alias '$alias'."
	exit 1
    fi

    echo "⌛Removing SSH key files for alias '$alias'..."
    rm -f "$key_path" "$key_path.pub"

    echo "⏳Cleaning SSH config..."
    awk -v alias="$alias" '
        $0 ~ "^Host " alias "$" { skip=1; next }
        skip && /^Host / { skip=0 }
        !skip { print }
    ' "$SSH_CONFIG" > "${SSH_CONFIG}.tmp"

    mv "${SSH_CONFIG}.tmp" "$SSH_CONFIG"
    chmod 600 "$SSH_CONFIG"
    echo "✅ Key and config for alias '$alias' removed."
}

# entry point

if [[ $# -lt 2 ]]; then
   echo "Usage:"
   echo "    $0 create <alias> <user> <comment>"
   echo "    $0 remove <alias>"
   exit 1
fi

action="$1"
alias="$2"

mkdir -p "$SSH_DIR"
touch "$SSH_CONFIG"

case "$action" in 
    create)
	if [[ $# -ne 4 ]]; then
	    echo "Error: 'create' requires an alias, a user, and a comment."
	    exit 1
	fi
	comment="$3"
	create_key "$alias" "$user" "$comment"
	;;
    remove)
	remove_key "$alias"
	;;
    *)
	echo "Unknown command: $action"
	exit 1
	;;
esac
