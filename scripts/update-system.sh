#!/usr/sbin/sh

echo "[*] Launching script to update system..."

printf "[*] Check pacman updates? [Y/n]: "
read answer

if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then 
    echo "[+] Checking pacman packages..."
    echo
    sudo pacman -Syu
    pkill -RTMIN+8 waybar
    echo 
fi

printf "[*] Check AUR packages? [Y/n]: "
read answer

if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then 
    echo "[+] Checking AUR packages with yay..."
    echo
    yay -Syu
    echo
fi

printf "[+] Done. Press ENTER the exit..."
read quit
