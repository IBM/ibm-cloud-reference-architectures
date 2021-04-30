#!/bin/bash

ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-openvpn
ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-bastion
ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-scc
ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-openvpn
ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-bastion
ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-scc
