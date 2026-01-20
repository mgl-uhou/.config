#!/usr/bin/env bash

## Adaptado para ZorinOS + BSPWM
## Autor Original : Aditya Shakya

# Configurações Visuais Simples (Para funcionar sem arquivos .rasi externos)
# Se você tiver um tema, mude use_theme para "true"
use_theme="true"
rasi_file="$HOME/.config/rofi/powermenu/menu.rasi" 

# Opções com Ícones (Verifique se sua Nerd Font suporta estes)
shutdown='  Shutdown'
reboot='  Reboot'
lock='  Lock'
suspend='  Suspend'
logout='  Logout'
yes='  Yes'
no=' No'

# Função para rodar o Rofi
rofi_cmd() {
    if [ "$use_theme" = "true" ]; then
        rofi -dmenu -p "System" -theme "$rasi_file"
    else
        # Usa estilo padrão com algumas cores manuais se não tiver tema
        rofi -dmenu -p "System" \
            -location 0 \
            -font "JetBrainsMono Nerd Font 12"
    fi
}

# Confirmação simples
confirm_cmd() {
    rofi -dmenu \
        -p 'Are you sure?' \
        -theme "$HOME/.config/rofi/powermenu/shared/confirm.rasi"
}

# Pergunta confirmação
confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

run_cmd() {
    # Se você quiser confirmação para tudo, descomente a linha abaixo:
    selected="$(confirm_exit)"
    if [[ "$selected" != "$yes" ]]; then exit 0; fi

    if [[ $1 == '--shutdown' ]]; then
        systemctl poweroff
    elif [[ $1 == '--reboot' ]]; then
        systemctl reboot
    elif [[ $1 == '--suspend' ]]; then
        # Primeiro manda para a tela do GDM, depois suspende
        gdmflexiserver & 
        nohup sh -c "sleep 4 && sudo systemctl suspend -i" >/dev/null 2>&1 &
    elif [[ $1 == '--logout' ]]; then
        if pgrep -x "sway" > /dev/null; then
            swaymsg exit
        else
            # Força o kill do BSPWM sem checar variáveis de ambiente
            bspc quit
        fi
    elif [[ $1 == '--lock' ]]; then
      gdmflexiserver
    fi
}

# Ações
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        run_cmd --lock
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
