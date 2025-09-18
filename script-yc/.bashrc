export YC_SA_NAME=otus
export YC_NETWORK_NAME=internal-network
export YC_SUBNET_NAME=internal-subnet
export YC_FOLDER_ID=$(yc config get folder-id)
export YC_ZONE=ru-central1-b
export YC_SUBNET_RANGE="172.16.16.0/24"

function log() {
    echo $(date) "| INFO:" $@
}