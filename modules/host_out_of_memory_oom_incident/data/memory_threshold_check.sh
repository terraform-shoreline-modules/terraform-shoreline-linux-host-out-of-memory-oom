#!/bin/bash



# Define threshold for memory usage

THRESHOLD=80



# Get current memory usage

CURRENT_USAGE=$(free | awk '/^Mem:/{print $3/$2 * 100.0}')



# Check if current usage exceeds threshold

if (( $(echo "$CURRENT_USAGE > $THRESHOLD" | bc -l) )); then

    # List processes by memory usage

    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 11

fi