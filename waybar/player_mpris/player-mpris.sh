#!/bin/bash

# A flag -a (--all-players) é crucial aqui.
# Sem ela, o playerctl só olha o primeiro da lista (KDE Connect) e ignora o navegador.
playerctl -a metadata --format '{{status}}: {{artist}} - {{title}}' 2>/dev/null | grep '^Playing:' | head -n1 | cut -d ':' -f 2- | sed 's/^ //'
