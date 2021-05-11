#!/bin/bash

echo "Generating ssh keys"

ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-openvpn -q
ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-bastion -q
ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-scc -q
ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-openvpn -q
ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-bastion -q
ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-scc -q
