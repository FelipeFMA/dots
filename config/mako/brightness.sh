#!/bin/dash
# brightness.sh — mako-friendly notification update using synchronous tag

# Ajusta o brilho com o comando brightnessctl, com o argumento recebido
brightnessctl "$@" > /dev/null

# Obtém o brilho atual
brightness="$(brightnessctl g | awk '{print int($1)}')"
max_brightness="$(brightnessctl m | awk '{print int($1)}')"

# Evita divisão por zero caso max_brightness não seja retornado corretamente
if [ -z "$max_brightness" ] || [ "$max_brightness" -eq 0 ]; then
    percentage=0
else
    percentage=$((brightness * 100 / max_brightness))
fi

APP_NAME="changeBrightness"
TIMEOUT=2000
SYNC_TAG="string:x-canonical-private-synchronous:brightness"

if [ "$brightness" -eq 0 ]; then
    notify-send "Brightness: OFF" \
        -a "$APP_NAME" -u low -i "dialog-information" -t "$TIMEOUT" \
        -h "$SYNC_TAG"
else
    notify-send "Brightness: ${percentage}%" \
        -a "$APP_NAME" -u low -i "dialog-information" -t "$TIMEOUT" \
        -h int:value:"$percentage" -h "$SYNC_TAG"
fi
