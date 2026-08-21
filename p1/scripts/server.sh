#!/bin/bash
set -e

IFACE="enp0s1"
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

echo "==> Waiting for node-token to be generated..."
until [ -f /var/lib/rancher/k3s/server/node-token ]; do
  sleep 2
done

echo "==> Sharing node-token with worker via synced folder..."
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token
sudo chmod 644 /vagrant/node-token

echo "==> K3s server ready at ${STATIC_IP}"