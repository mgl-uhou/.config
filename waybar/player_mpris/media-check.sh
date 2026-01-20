#!/bin/bash

# Verifica em TODOS os players (-a) se algum está tocando
if playerctl -a status 2>/dev/null | grep -q "Playing"; then
    echo "$1"
else
    echo ""
fi