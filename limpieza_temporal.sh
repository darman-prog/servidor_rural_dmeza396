#!/bin/bash
TEMP_DIR="/dmeza396/escuela_rural/temporal"
LOG="/dmeza396/escuela_rural/sistemas/logs/limpieza.log"

# Validar que el directorio exista y que sea exactamente el esperado
if [ ! -d "$TEMP_DIR" ]; then
    echo "Error: el directorio temporal no existe."
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Inicio de limpieza en $TEMP_DIR" >> "$LOG"

# Buscar archivos con más de 7 días de antigüedad
ARCHIVOS=$(find "$TEMP_DIR" -type f -mtime +7)

if [ -z "$ARCHIVOS" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - No se encontraron archivos para eliminar" >> "$LOG"
    echo "No hay archivos con más de 7 días de antigüedad."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Archivos encontrados:" >> "$LOG"
    echo "$ARCHIVOS" >> "$LOG"

    # Eliminar únicamente esos archivos, dentro de temporal
    find "$TEMP_DIR" -type f -mtime +7 -exec rm -v {} \; >> "$LOG"

    echo "$(date '+%Y-%m-%d %H:%M:%S') - Limpieza finalizada" >> "$LOG"
    echo "Archivos eliminados. Revisa el log para más detalle."
fi
