#!/bin/bash

PLAYER_STATUS=$(playerctl status 2> /dev/null)

if [ "$PLAYER_STATUS" = "Playing" ]; then
    echo "$(playerctl metadata artist) - $(playerctl metadata title)"
elif [ "$PLAYER_STATUS" = "Paused" ]; then
    echo ""
else
    echo ""
fi
