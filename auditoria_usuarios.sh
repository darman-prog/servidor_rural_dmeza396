#!/bin/bash

REPORTES="/dmeza396/escuela_rural/sistemas/reportes"
FECHA=$(date +%Y%m%d_%H%M%S)
ARCHIVO="$REPORTES/auditoria_${FECHA}.txt"

USUARIOS="prim01 prim02 prim03 prim04 prim05 bach01 bach02 bach03 bach04 bach05 bach06 bach07 bach08 secretaria coord01 coord02 rector sysadmin"

{
    echo "=== AUDITORÍA DE USUARIOS - $(date '+%Y-%m-%d %H:%M:%S') ==="
    for u in $USUARIOS; do
        if id "$u" &>/dev/null; then
            echo "-----------------------------"
            echo "Usuario: $u"
            echo "UID: $(id -u "$u")"
            echo "Grupo principal: $(id -gn "$u")"
            echo "Grupos secundarios: $(groups "$u" | cut -d: -f2)"
            echo "Directorio personal: $(getent passwd "$u" | cut -d: -f6)"
            echo "Shell: $(getent passwd "$u" | cut -d: -f7)"
        else
            echo "Advertencia: el usuario $u no existe."
        fi
    done
} > "$ARCHIVO"

echo "Auditoría generada en: $ARCHIVO"
