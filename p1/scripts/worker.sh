#!/bin/bash
set -e

IFACE="enp0s1"
STATIC_IP="192.168.56.111"
SERVER_IP="192.168.56.110"

echo "==> Waiting for $IFACE to be up..."
for i in $(seq 1 30); do
  if ip link show "$IFACE" | grep -q "state UP"; then
    break
  fi
  sleep 1
done

echo "==> Assigning static IP $STATIC_IP to $IFACE..."
sudo ip addr add "${STATIC_IP}/24" dev "$IFACE" 2>/dev/null || true

echo "==> Waiting for K3s node-token from server..."
until [ -f /vagrant/node-token ]; do
  sleep 5
done
K3S_TOKEN=$(cat /vagrant/node-token)

echo "==> Waiting for server to be reachable at ${SERVER_IP}:6443..."
until curl -sk --max-time 2 "https://${SERVER_IP}:6443" >/dev/null 2>&1; do
  sleep 3
done

echo "==> Installing K3s in agent mode..."
curl -sfL https://get.k3s.io | K3S_URL="https://${SERVER_IP}:6443" K3S_TOKEN="${K3S_TOKEN}" INSTALL_K3S_EXEC="--node-ip=${STATIC_IP} --flannel-iface=${IFACE}" sh -

echo "==> K3s agent joined to cluster at ${SERVER_IP}"