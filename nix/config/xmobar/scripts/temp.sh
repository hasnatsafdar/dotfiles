#!/usr/bin/env bash
# Read thermal_zone0 in millidegrees
TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
TEMP_C=$(echo "scale=1; $TEMP/1000" | bc)
echo "<fc=#f7768e> $TEMP_C°C</fc>"
