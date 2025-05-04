#!/bin/bash

# Variables
SERVER_NAME="mikorh-server"
SERVER_TYPE="cx22"
IMAGE="alma-9"
SSH_KEY_NAME="mch-portatil"
LOCATION="fsn1" # Cambia esto si prefieres otra ubicación, como "nbg1" o "hel1"
CLOUD_INIT_FILE="cloud-init.yml"
FIREWALL_NAME="firewall-1"

# Instalar jq si no está instalado
if ! command -v jq &> /dev/null; then
  echo "jq no está instalado. Instalando..."
  apt-get install -y jq
fi

# Crear el servidor
hcloud server create \
  --name "$SERVER_NAME" \
  --type "$SERVER_TYPE" \
  --image "$IMAGE" \
  --ssh-key "$SSH_KEY_NAME" \
  --location "$LOCATION" \
  --user-data-from-file "$CLOUD_INIT_FILE"

# Verificar si el servidor fue creado correctamente
if [ $? -eq 0 ]; then
  echo "El servidor '$SERVER_NAME' ha sido creado exitosamente."

  # Obtener el ID del servidor recién creado
  SERVER_ID=$(hcloud server list --selector "name=$SERVER_NAME" -o json | jq -r '.[0].id')

  # Aplicar el firewall al servidor
  hcloud firewall apply-to-resource "$FIREWALL_NAME" --type server --server "$SERVER_ID"
  if [ $? -eq 0 ]; then
    echo "El firewall '$FIREWALL_NAME' ha sido aplicado al servidor '$SERVER_NAME'."
  else
    echo "Error al aplicar el firewall '$FIREWALL_NAME' al servidor '$SERVER_NAME'."
    exit 1
  fi
else
  echo "Error al crear el servidor '$SERVER_NAME'."
  exit 1
fi