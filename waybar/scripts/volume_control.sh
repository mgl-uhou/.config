#!/bin/bash

step=5
limit=100

# Get current volume (first percentage found)
current=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n 1)

# Ensure current is a number, default to 0 if empty
if [ -z "$current" ]; then
    current=0
fi

if [ "$1" == "up" ]; then
    # Calculate new volume
    new_vol=$((current + step))
    
    # If new volume is greater than limit, set to limit (or do nothing if already at limit)
    if [ "$new_vol" -gt "$limit" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ ${limit}%
    else
        pactl set-sink-volume @DEFAULT_SINK@ +${step}%
    fi
elif [ "$1" == "down" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ -${step}%
fi