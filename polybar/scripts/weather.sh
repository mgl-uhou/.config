#!/usr/bin/env bash

# Verifica se o comando curl existe
if ! command -v curl &> /dev/null; then
    exit 1
fi

# Tenta pegar o clima.
# %C = Condição do tempo (ex: Clear, Cloudy, Rain)
# %t = Temperatura
# Usamos lang=en para garantir que as condições venham em inglês para o mapeamento funcionar.
WEATHER_DATA=$(curl -sf "wttr.in/?format=%C+%t&lang=en")

if [ -z "$WEATHER_DATA" ]; then
    echo ""
    exit 0
fi

# Separa a condição e a temperatura
# O delimitador é o '+' que colocamos no formato
CONDITION=$(echo "$WEATHER_DATA" | cut -d'+' -f1)
TEMP=$(echo "$WEATHER_DATA" | cut -d'+' -f2)

# Mapeamento de Ícones (Nerd Fonts)
case "$CONDITION" in
    "Clear" | "Sunny")
        ICON="" # weather-sunny
        ;;
    "Partly cloudy")
        ICON="" # weather-partly-cloudy
        ;;
    "Cloudy")
        ICON="" # weather-cloudy
        ;;
    "Overcast")
        ICON="" # weather-cloudy
        ;;
    "Mist" | "Fog" | "Haze")
        ICON="" # weather-fog
        ;;
    *"Rain"* | *"Drizzle"* | *"Showers"*)
        ICON="" # weather-rain
        ;;
    *"Snow"*)
        ICON="" # weather-snow
        ;;
    *"Thunder"* | *"Lightning"*)
        ICON="" # weather-lightning
        ;;
    *)
        ICON="" # Default (partly cloudy)
        ;;
esac

# Exibe o ícone e a temperatura
echo "$ICON $TEMP"