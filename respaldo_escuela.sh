#!/bin/bash

ORIGEN="/dmeza396/escuela_rural/academico"
DESTINO="/dmeza396/escuela_rural/sistemas/respaldos"
LOG="/dmeza396/escuela_rural/sistemas/logs/respaldos.log"
FECHA=$(date +%Y%m%d_%H%M%S)
ARCHIVO="academico_${FECHA}.tar.gz"

# Validar que el directorio origen exista
if [ ! -d "$ORIGEN" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: directorio origen no encontrado" >> "$LOG"
    echo "Error: no se encontró el directorio $ORIGEN"
    exit 1
fi

tar -czf "$DESTINO/$ARCHIVO" -C "$(dirname "$ORIGEN")" "$(basename "$ORIGEN")"

if [ $? -eq 0 ]; then
    echo "Respaldo generado correctamente: $ARCHIVO"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Respaldo OK: $ARCHIVO" >> "$LOG"
else
    echo "Error al generar el respaldo."
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR al generar respaldo" >> "$LOG"
    exit 1
fi
