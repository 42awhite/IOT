#!/bin/bash
curl -sfL https://get.k3s.io | sh -s - server \
  --token="MiTokenSecreto42" \
  --node-ip="192.168.56.110" \
  --flannel-iface="eth1" \
  --write-kubeconfig-mode="644"