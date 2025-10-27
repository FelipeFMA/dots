#!/bin/dash

# volume.sh — mako-friendly notification update using synchronous tag

# Read volume and mute status using pactl only (no fallbacks)
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F'/' '/%/ {gsub("%","",$2); print int($2); exit}')
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Common notify-send args
APP_NAME="changeVolume"
TIMEOUT=1500


# Use the Canonical synchronous hint to make mako replace in-place (POSIX)
SYNC_TAG="string:x-canonical-private-synchronous:volume"

if [ "$volume" -eq 0 ] || [ "$mute" = "yes" ]; then
	notify-send "Volume muted" \
		-a "$APP_NAME" -u low -i audio-volume-muted -t "$TIMEOUT" \
		-h "$SYNC_TAG"
else
	notify-send "Volume: ${volume}%" \
		-a "$APP_NAME" -u low -i audio-volume-high -t "$TIMEOUT" \
		-h int:value:"$volume" -h "$SYNC_TAG"
fi

# Optional feedback sound
canberra-gtk-play -i audio-volume-change -d "$APP_NAME" 2>/dev/null || true
