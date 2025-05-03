#!/bin/bash

# Variables
SERVER_NAME="mikorh-server"
SERVER_TYPE="cx22"
IMAGE="alma-9"
SSH_KEY_NAME="mch-portatil"
LOCATION="fsn1" # Cambia esto si prefieres otra ubicación, como "nbg1" o "hel1"

# Crear el servidor
hcloud server create \
  --name "$SERVER_NAME" \
  --type "$SERVER_TYPE" \
  --image "$IMAGE" \
  --ssh-key "$SSH_KEY_NAME" \
  --location "$LOCATION"

# Verificar si el servidor fue creado correctamente
if [ $? -eq 0 ]; then
  echo "El servidor '$SERVER_NAME' ha sido creado exitosamente."
else
  echo "Error al crear el servidor '$SERVER_NAME'."
  exit 1
fi