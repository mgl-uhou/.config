#!/bin/bash

# Mata instâncias antigas para não duplicar
killall -q cava
sleep 0.1

# 1. Executa o cava
# 2. sed -u 's/^0;0;0;0;0;0;0;0;0;0;0;0;$//' : Apaga linhas de silêncio (fica linha vazia)
# 3. sed -u 's/;//g; s/0/ /g; s/1/▂/g; ...' : Transforma números em ícones
cava -p ~/.config/cava/config1 | sed -u '
    # s/^0;0;0;0;0;0;0;0;0;0;0;0;$//;
    s/;//g;
    s/0/▂/g;
    s/1/▃/g;
    s/2/▄/g;
    s/3/▅/g;
    s/4/▇/g;
    s/5/▇/g;
    s/6/▇/g;
    s/7/█/g'
