#!/bin/bash
set -e

IFACE="eth1"
STATIC_IP="192.168.56.110"

echo "==> Waiting for $IFACE to be up..."
for i in $(seq 1 30); do
  if ip link show "$IFACE" | grep -q "state UP"; then
    break
  fi
  sleep 1
done

echo "==> Assigning static IP $STATIC_IP to $IFACE..."
sudo ip addr add "${STATIC_IP}/24" dev "$IFACE" 2>/dev/null || true

echo "==> Installing K3s in server (controller) mode..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=${STATIC_IP} --bind-address=${STATIC_IP} --advertise-address=${STATIC_IP} --flannel-iface=${IFACE}" sh -


echo "==> Waiting for K3s API server to register the node..."
until sudo kubectl get nodes &>/dev/null; do
  sleep 2
done

echo "==> Waiting for node to be Ready..."
sudo kubectl wait --for=condition=Ready node --all --timeout=60s

echo "==> Applying application manifests..."
sudo kubectl apply -f /vagrant/confs/