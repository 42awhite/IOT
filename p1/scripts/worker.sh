#!/bin/bash

curl -sfL https://get.k3s.io | \
K3S_URL=https://192.168.56.110:6443 \
K3S_TOKEN=MiTokenSecreto42 \
sh -s - --node-ip=192.168.56.111 --flannel-iface=eth1