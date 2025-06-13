#!/bin/bash

if updates=$(checkupdates | grep -c . | grep -v '^0$'); then 
    echo " $updates"
else
    echo ""
fi
