#!/bin/bash

REPORTES="/dmeza396/escuela_rural/sistemas/reportes"
FECHA=$(date +%Y%m%d_%H%M%S)
ARCHIVO="$REPORTES/estado_${FECHA}.txt"

# Validar que exista el directorio de reportes
if [ ! -d "$REPORTES" ]; then
    echo "Error: no existe el directorio de reportes."
    exit 1
fi

{
    echo "=== REPORTE DE ESTADO DEL SERVIDOR ==="
    echo "Fecha y hora: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Nombre del servidor: $(hostname)"
    echo "Tiempo encendido: $(uptime -p)"
    echo "Memoria RAM utilizada:"
    free -h
    echo "Espacio disponible en disco:"
    df -h
    echo "Usuarios conectados:"
    who
    echo "Uso de almacenamiento de /dmeza396:"
    du -sh /dmeza396
    echo "Últimos accesos registrados:"
    last -n 10
} > "$ARCHIVO"

echo "Reporte generado en: $ARCHIVO"
