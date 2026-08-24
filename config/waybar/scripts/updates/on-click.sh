#!/usr/sbin/sh

BLUE="\e[34m"
BLUE_BOLD="\e[1;34m"
BLUE_BOLD_ITALIC="\e[1;3;34m"
RESET="\e[0m"

echo -e "${BLUE_BOLD}[*] SYSTEM UPDATES${RESET}"

printf "\n${BLUE}[*] Check ${BLUE_BOLD}pacman${RESET} ${BLUE}updates[Y/n]: ${RESET}"
read answer

if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then 
    echo -e "\n[+] Checking pacman packages..."
    echo
    sudo pacman -Syu
    echo 
fi

printf "\n${BLUE}[*] Check ${BLUE_BOLD}yay${RESET} ${BLUE}updates[Y/n]: ${RESET}"
read answer

if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then 
    echo -e "\n[+] Checking AUR packages with yay..."
    echo
    yay -Syu
    echo
fi


echo -e "\n${BLUE_BOLD}[*] PRESS ENTER TO QUIT${RESET}"

pkill -RTMIN+8 waybar

read quit
