#!/bin/bash
curl -sfL https://get.k3s.io | sh -s - agent \
  --server="https://192.168.56.110:6443" \
  --token="MiTokenSecreto42" \
  --node-ip="192.168.56.111" \
  --flannel-iface="eth1"
