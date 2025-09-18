#!/bin/bash
# Установка переменных
source .bashrc

# Создание сети
yc vpc network create --name $YC_NETWORK_NAME \
    --folder-id $YC_FOLDER_ID

# Создание подсети
log "Creating subnet $YC_SUBNET_NAME..."
yc vpc subnet create \
    --name $YC_SUBNET_NAME \
    --zone $YC_ZONE \
    --range $YC_SUBNET_RANGE \
    --network-name $YC_NETWORK_NAME \
    --folder-id $YC_FOLDER_ID