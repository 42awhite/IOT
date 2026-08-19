# IOT
## 🚀 Part 2 — K3s and Three Simple Applications

A single K3s server node hosting **3 web applications**, routed by **Ingress** based on the `Host` header of incoming requests to `192.168.56.110`:

| Host | App | Replicas |
|------|-----|----------|
| `app1.com` | App 1 | 1 |
| `app2.com` | App 2 | 3 |
| *(default)* | App 3 | 1 |