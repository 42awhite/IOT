# IOT
## 🔄 Part 3 — K3d and Argo CD

A lightweight **K3d** cluster (Docker-based, no Vagrant) running a full GitOps loop:

- **`argocd`** namespace — Argo CD instance
- **`dev`** namespace — application auto-deployed and synced by Argo CD from this public GitHub repo
- The deployed app (`wil42/playground` on Docker Hub, or a custom image) ships in **two tagged versions** (`v1` / `v2`)
- Changing the image tag in the repo and pushing triggers an automatic re-sync and redeploy via Argo CD

```bash
# Example: switching the deployed version
sed -i 's/playground:v1/playground:v2/g' deployment.yaml
git add . && git commit -m "bump to v2" && git push