# IOT
## 🎁 Bonus — GitLab

A local **GitLab** instance (latest stable release) integrated into the Part 3 cluster:

- Deployed in its own dedicated `gitlab` namespace
- Fully compatible with the existing Argo CD / K3d setup from Part 3

> ⚠️ The bonus is only evaluated if all mandatory parts (`p1`, `p2`, `p3`) are 100% functional.

## 🛠️ Tech Stack

`Vagrant` · `K3s` · `K3d` · `kubectl` · `Argo CD` · `Docker` · `GitLab` · `Ingress`

## 📋 Requirements

- Vagrant + a virtualization provider (VirtualBox, libvirt, etc.)
- Docker (required for K3d)
- `kubectl`