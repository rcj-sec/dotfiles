#!/bin/sh
# shellcheck shell=bash

wallpaper_fallback() {
    img=$1
    echo "[!] WARN: Failed to set the background."
    echo "          Falling back to previous background."
    echo "          Restarting hyprpaper"
    ln -sf "$img" "../wall.jpg"
    if ! systemctl --user restart hyprpaper; then
        echo "[X] ERR: Failed to set previous background."
        echo "         Ensure hyprpaper.service is running."
        echo "         Ensure hyprpaper can load the image."
        exit 2
    fi
}


help() {
	echo -e "\nCommands:"
	echo -e "    list           list available images"
	echo -e "    lock file      set image as lock screen wallpaper"
	echo -e "    wall file           set image as wallpaper"
	echo -e "    view           view image"
	echo -e "    exit           view image\n"
}

WALLPAPER_DIR=~/Pictures/wallpapers

cd $WALLPAPER_DIR || {
	echo "[X] Failed to open dir: $WALLPAPER_DIR"
	exit 1
}

echo -e "\nWallpaper manager\n"

while (true); do
	read -r -e -p "wpp.sh: " line
	eval set -- "$line"
	action="$1"
	image="$2"

	case "$action" in
	list)
		echo -e "\nIn $WALLPAPER_DIR:\n\n$(ls)\n"
		;;

	lock)
		if [[ -f "$image" ]]; then
			ln -sf "wallpapers/$image" ../lock.jpg
		else
			echo -e "\n[!] WARN: Image not found: $image\n"
		fi
		;;
	wall)
		if [[ -f "$image" ]]; then
			previous=$(readlink -f ../wall.jpg)
			ln -sf "wallpapers/$image" ../wall.jpg
			if ! systemctl --user is-active hyprpaper; then 
				echo "[!] WARN: hyprpaper is not running"
				echo "[!]       Restarting hyprpaper"
				if ! systemctl --user restart hyprpaper; then
                    # fallback to previous wallpaper
                    wallpaper_fallback "$previous"
				fi
			else
                echo "[+] OK: hyprland running as a service"
				ok=$(hyprctl hyprpaper reload , ~/Pictures/wall.jpg 2>/dev/null)
                if [[ "$ok" != "ok" ]]; then
                    # fallback to previous wallpaper
                    wallpaper_fallback "$previous"
                fi
			fi
			echo "[+] Wallpaper set."
		else
			echo -e "\n[!] WARN: Image not found: $image\n"
		fi
		;;
	view)
		if [[ -f "$image" ]]; then
			magick "$image" -resize 1024x576 tmp.jpg
			kitten icat tmp.jpg
			rm tmp.jpg
		else
			echo -e "\n[!] WARN: Image not found: $image\n"
		fi
		;;
	exit | q)
		exit 0
		;;
	help | h)
		help
		;;
	*)
		echo -e "\n[!] Unsupported option"
		help
		;;

	esac
done
