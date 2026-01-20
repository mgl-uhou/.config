#!/bin/bash
# Script de auto-suspensão para Sway (Chamado pelo swayidle)
# Baseado na lógica de: ~/.config/rofi/powermenu/powermenu.sh

# Verifica se há áudio tocando (opcional, o idle_inhibitor do waybar já deve lidar com isso se ativado manualmente,
# mas alguns players não inibem sozinhos. O Swayidle respeita o protocolo Wayland idle-inhibit).

# Executa o bloqueio de tela preferido (GDM)
gdmflexiserver &

# Aguarda um momento para o GDM carregar antes de suspender
sleep 4

# Suspende o sistema
# Nota: 'systemctl suspend' geralmente não precisa de sudo para o usuário logado localmente.
systemctl suspend -i
