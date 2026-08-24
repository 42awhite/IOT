#!/bin/bash
# 1. Instalación del servidor K3s (sin token hardcodeado)
curl -sfL https://get.k3s.io | sh -s - server \
  --node-ip="192.168.56.110" \
  --flannel-iface="eth1" \

# 2. Exportar el token generado dinámicamente a la carpeta compartida
sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/token