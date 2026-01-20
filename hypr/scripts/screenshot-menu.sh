#!/bin/bash

# Diretório de salvamento
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"

# Opções do Menu
OPT_SEL_COPY="  Select area and copy"
OPT_SEL_SAVE="  Select area and save"
OPT_FULL_COPY="  Fullscreen and copy"
OPT_FULL_SAVE="  Fullscreen and save"

# Escolha via Rofi
CHOICE=$(echo -e "$OPT_SEL_COPY\n$OPT_SEL_SAVE\n$OPT_FULL_COPY\n$OPT_FULL_SAVE" | rofi -dmenu -theme ~/.config/rofi/screenshot.rasi -p "Screenshot")

case "$CHOICE" in
	"$OPT_SEL_COPY")
		sleep 0.2 # Pequeno delay para o rofi fechar
		grim -g "$(slurp)" - | wl-copy && notify-send "Screenshot" "Area copied to the clipboard"
		;;
	"$OPT_SEL_SAVE")
		sleep 0.2
		grim -g "$(slurp)" "$DIR/$FILE" && notify-send "Screenshot" "Saved in $DIR"
		;;
	"$OPT_FULL_COPY")
		sleep 0.2
		grim - | wl-copy && notify-send "Screenshot" "Fullscreen copied"
		;;
	"$OPT_FULL_SAVE")
		sleep 0.2
		grim "$DIR/$FILE" && notify-send "Screenshot" "Fullscreen saved in $DIR"
		;;
esac
