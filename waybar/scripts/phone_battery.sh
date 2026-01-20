#!/bin/bash

DEVICE_ID="b3d59fcc6fe44d60829955e228bee614"

# Tenta qdbus-qt5 (comum no Zorin/Ubuntu) ou qdbus
if command -v qdbus-qt5 &> /dev/null; then
    QDBUS_CMD="qdbus-qt5"
else
    QDBUS_CMD="qdbus"
fi

STATUS=$($QDBUS_CMD org.kde.kdeconnect /modules/kdeconnect/devices/$DEVICE_ID org.kde.kdeconnect.device.isReachable 2>/dev/null)

if [ "$STATUS" = "true" ]; then
    BATTERY=$($QDBUS_CMD org.kde.kdeconnect /modules/kdeconnect/devices/$DEVICE_ID/battery org.kde.kdeconnect.device.battery.charge)
    CHARGING=$($QDBUS_CMD org.kde.kdeconnect /modules/kdeconnect/devices/$DEVICE_ID/battery org.kde.kdeconnect.device.battery.isCharging)

    # 1. Ícone do Celular (Sempre aparece primeiro)
    PHONE_ICON=""

    # 2. Ícone da Bateria (Muda se carrega ou não)
    if [ "$CHARGING" = "true" ]; then
        PHONE_ICON="󱐌"
        # BAT_ICON="󰂄" 
    # else
    #     if [ "$BATTERY" -le 15 ]; then
    #         BAT_ICON="󰂃" 
    #     elif [ "$BATTERY" -le 50 ]; then
    #         BAT_ICON="󰁼"
    #     elif [ "$BATTERY" -le 90 ]; then
    #         BAT_ICON="󰂀"
    #     else
    #         BAT_ICON="󰁹"
    #     fi
    fi
    
    # Resultado: [Celular] [Status Bateria] [Valor]%
    echo "$PHONE_ICON  $BATTERY%"
else
    echo "" 
fi
