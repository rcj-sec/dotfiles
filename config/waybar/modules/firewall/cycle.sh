#!/bin/bash

zone=$(firewall-cmd --get-default-zone)

if [[ "$zone" == "public" ]]; then 
    firewall-cmd --set-default-zone=block
elif [[ "$zone" == "block" ]]; then
    firewall-cmd --set-default-zone=public
else
    firewall-cmd --set-default-zone=block
fi

pkill -RTMIN+8 waybar 

