# IOT
## 📦 Part 1 — K3s and Vagrant

Two virtual machines provisioned with a single `Vagrantfile`, using the latest stable Linux distribution and minimal resources (1 CPU / 512–1024 MB RAM).

- **Server** (`<login>S`) — `192.168.56.110` — K3s installed in **controller** mode
- **ServerWorker** (`<login>SW`) — `192.168.56.111` — K3s installed in **agent** mode
- Passwordless SSH access to both machines
- `kubectl` installed and configured to manage the cluster