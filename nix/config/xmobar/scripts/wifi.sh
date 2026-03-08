#!/usr/bin/env bash
IFACE=wlp3s0
SSID=$(iw dev $IFACE link | grep 'SSID' | awk '{print $2}')
if [ -z "$SSID" ]; then
    echo "<fc=#dc322f>睊 Disconnected</fc>"
else
    SIGNAL=$(grep $IFACE /proc/net/wireless | awk '{print int($3*100/70)}')
    echo "<fc=#7aa2f7> $SSID $SIGNAL%</fc>"
fi
