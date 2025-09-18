#!/bin/bash
source .bashrc

vm_name=$1

yc compute instance create \
    --preemptible \
    --name $vm_name \
    --hostname $vm_name \
    --zone ${YC_ZONE} \
    --memory=2 \
    --cores=2 \
    --create-boot-disk `
        `image-folder-id=standard-images,`
        `image-family=ubuntu-2204-lts,`
        `type=network-ssd,`
        `size=20 \
    --network-interface subnet-name=${YC_SUBNET_NAME},ipv4-address=auto \
    --metadata-from-file user-data=metadata.yaml