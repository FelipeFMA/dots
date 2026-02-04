#!/bin/bash

CHOICE=$(echo -e "󰌪   Powersave\n   Performance" | hyprlauncher --dmenu)

case "$CHOICE" in
    "󰌪   Powersave")
        ~/.config/hypr/battery.sh
        ;;
    "   Performance")
        ~/.config/hypr/ac.sh
        ;;
    *)
        exit 0
        ;;
esac
