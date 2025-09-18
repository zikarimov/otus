#!/bin/bash

yc compute instance attach-network-interface \
  --id vm-id \
  --subnet-id subnet-id \
  --network-interface-index 1 \
  --security-group-id secure-id \
  --ipv4-address=auto

