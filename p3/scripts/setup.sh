#!/bin/bash
set -e

# 1. Instalación directa de dependencias si no existen
command -v docker || (curl -fsSL https://get.docker.com | sh && sudo usermod -aG docker $USER)
command -v k3d || curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
command -v kubectl || (curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl && sudo mv kubectl /usr/local/bin/)

# 2. Creación del clúster k3d con mapeo del puerto 8888
k3d cluster create iot-cluster -p "8888:8888@loadbalancer" || true

# 3. Namespaces requeridos
kubectl create ns argocd || true
kubectl create ns dev || true

# 4. Despliegue de Argo CD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 5. Espera a controladores y vinculación de la app GitOps
kubectl wait --for=condition=ready pod --all -n argocd --timeout=180s
kubectl apply -f "$(dirname "$0")/../confs/application.yaml"