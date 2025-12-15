#!/bin/bash

updates=$(checkupdates | wc -l)

if (( updates > 0 )) then 
    echo " $updates"
    notify-send "System Updates" "You have $updates pending updates." -r 1001
else
    echo " 0"
fi
