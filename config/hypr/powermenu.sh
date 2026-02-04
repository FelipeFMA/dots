#!/bin/bash

CHOICE=$(echo -e "   Suspend\n   Shutdown\n   Reboot" | hyprlauncher --dmenu)

case "$CHOICE" in
    "   Suspend")
        hyprlock & sleep 1 & systemctl suspend
        ;;
    "   Shutdown")
        systemctl poweroff
        ;;
    "   Reboot")
        systemctl reboot
        ;;
    *)
        exit 0
        ;;
esac
