#!/usr/bin/env bash
VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
if [ "$MUTE" = "yes" ]; then
    echo "<fc=#dc322f><fn=1></fn> MUTE</fc>"
else
    echo "<fc=#859900><fn=1></fn> $VOL</fc>"
fi
