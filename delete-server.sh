#!/bin/bash

# Variables
SERVER_NAME="mikorh-server"

# Borrar el servidor
hcloud server delete "$SERVER_NAME"

# Verificar si el servidor fue borrado correctamente
if [ $? -eq 0 ]; then
  echo "El servidor '$SERVER_NAME' ha sido borrado exitosamente."
else
  echo "Error al borrar el servidor '$SERVER_NAME'."
  exit 1
fi