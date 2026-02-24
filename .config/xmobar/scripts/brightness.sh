#!/usr/bin/env bash
BR=$(brightnessctl get)
MAX=$(brightnessctl max)
PERC=$(( BR * 100 / MAX ))
echo "<fc=#f5c359>☀ $PERC%</fc>"
