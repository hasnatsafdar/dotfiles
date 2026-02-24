#!/usr/bin/env bash
read total used free <<< $(free -k | awk 'NR==2{printf "%d %d %d\n", $2, $3, $4}')

if [ "$used" -lt 1048576 ]; then  # used < 1 GB (in KB)
    used_fmt=$(awk "BEGIN {printf \"%.0f\", $used/1024}")
    total_fmt=$(awk "BEGIN {printf \"%.0f\", $total/1024}")
    unit="MB"
else
    used_fmt=$(awk "BEGIN {printf \"%.1f\", $used/1024/1024}")
    total_fmt=$(awk "BEGIN {printf \"%.1f\", $total/1024/1024}")
    unit="GB"
fi

echo "<fc=#7aa2f7>󰍛 MEM:</fc> $used_fmt/$total_fmt $unit"
