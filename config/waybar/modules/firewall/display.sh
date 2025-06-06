#!/bin/bash

zone=$(firewall-cmd --get-default-zone)
zone="󰈸 ${zone^}"
echo "$zone" 
