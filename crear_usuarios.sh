#!/bin/bash

LOG="/dmeza396/escuela_rural/sistemas/logs/usuarios.log"

# Validar que se recibieron los 3 parámetros
if [ $# -ne 3 ]; then
    echo "Uso: $0 <usuario> <grupo> <directorio_personal>"
    exit 1
fi

USUARIO=$1
GRUPO=$2
HOME_DIR=$3

# Validar si el usuario ya existe
if id "$USUARIO" &>/dev/null; then
    echo "El usuario '$USUARIO' ya existe. No se creará de nuevo."
    exit 1
fi

# Validar si el grupo existe
if ! getent group "$GRUPO" &>/dev/null; then
    echo "Error: el grupo '$GRUPO' no existe. Créalo antes de continuar."
    exit 1
fi

# Crear el usuario
useradd -m -d "$HOME_DIR" -g "$GRUPO" "$USUARIO"

if [ $? -eq 0 ]; then
    echo "Usuario '$USUARIO' creado correctamente en el grupo '$GRUPO'."
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Usuario creado: $USUARIO - Grupo: $GRUPO" >> "$LOG"
else
    echo "Error al crear el usuario '$USUARIO'."
    exit 1
fi
