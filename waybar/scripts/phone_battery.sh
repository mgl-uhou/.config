#!/bin/bash

DEVICE_ID="b3d59fcc6fe44d60829955e228bee614"

# Função para pegar propriedade via busctl
get_prop() {
    # $1: Interface, $2: Property
    busctl --user get-property org.kde.kdeconnect /modules/kdeconnect/devices/$DEVICE_ID/$1 org.kde.kdeconnect.device.$1 $2 2>/dev/null | awk '{print $2}'
}

# Verifica se está alcançável (busctl retorna "true" ou "false")
STATUS=$(busctl --user get-property org.kde.kdeconnect /modules/kdeconnect/devices/$DEVICE_ID org.kde.kdeconnect.device isReachable 2>/dev/null | awk '{print $2}')

if [ "$STATUS" = "true" ]; then
    BATTERY=$(get_prop "battery" "charge")
    CHARGING=$(get_prop "battery" "isCharging")

    # 1. Ícone do Celular
    PHONE_ICON=""

    # 2. Ícone da Bateria
    if [ "$CHARGING" = "true" ]; then
        PHONE_ICON="󱐌"
    fi
    
    # Resultado: [Icone] [Valor]%
    echo "$PHONE_ICON  $BATTERY%"
else
    echo "" 
fi