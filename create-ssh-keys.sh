#!/bin/bash

echo "Generating ssh keys"

#ssh-keygen -t rsa -b 3072 -N "" -f ssh-edge-openvpn -q
ssh-keygen -t rsa -b 3072 -N "" -f ssh-edge-bastion -q
ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-scc -q
ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-scc -q
