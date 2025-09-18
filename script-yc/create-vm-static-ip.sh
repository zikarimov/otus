#!/bin/bash
source .bashrc

vm_name=$1

# Создание статического IP-адреса и получение его адреса
STATIC_IP_DATA=$(yc vpc address create \
  --external-ipv4 zone=${YC_ZONE} \
  --format json)

STATIC_IP_ID=$(echo $STATIC_IP_DATA | jq -r '.id')
STATIC_IP_ADDRESS=$(echo $STATIC_IP_DATA | jq -r '.external_ipv4_address.address')

log "Создан статический IP: $STATIC_IP_ADDRESS (ID: $STATIC_IP_ID)"

# Создание виртуальной машины
yc compute instance create \
    --preemptible \
    --name $vm_name \
    --hostname $vm_name \
    --zone ${YC_ZONE} \
    --memory=2 \
    --cores=2 \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts,type=network-ssd,size=20 \
    --network-interface subnet-name=${YC_SUBNET_NAME},nat-ip-version=ipv4,nat-address=${STATIC_IP_ADDRESS} \
    --metadata-from-file user-data=metadata.yaml