# deploy-scripts
This Repo will used for deploying the front end and backend
Here are clean, scalable, and convention-friendly **naming suggestions** for your `deploy-scripts` repo intended for hosting Helm charts and deployment automation on **Hostinger** (or similar):

---

### ✅ Recommended Folder & File Structure

```
deploy-scripts/
├── README.md
├── charts/
│   ├── backend/
│   │   ├── Chart.yaml
│   │   ├── values.yaml
│   │   ├── templates/
│   │   │   ├── deployment.yaml
│   │   │   ├── service.yaml
│   │   │   └── ingress.yaml
│   ├── frontend/
│   │   ├── Chart.yaml
│   │   ├── values.yaml
│   │   ├── templates/
│   │   │   ├── deployment.yaml
│   │   │   ├── service.yaml
│   │   │   └── ingress.yaml
├── secrets/
│   ├── backend-secrets.yaml
│   ├── frontend-secrets.yaml
├── environments/
│   ├── hostinger/
│   │   ├── values-backend.yaml
│   │   ├── values-frontend.yaml
│   ├── dev/
│   ├── prod/
├── scripts/
│   ├── deploy-hostinger.sh
│   ├── delete-release.sh
│   └── upgrade-release.sh
└── .env.template
```

---

### ✅ Naming Conventions

| Type               | Suggestion                | Notes                                |
| ------------------ | ------------------------- | ------------------------------------ |
| **Helm Release**   | `dr-backend` / `dr-ui`    | `dr` = DonateRaja                    |
| **Chart Names**    | `backend`, `frontend`     | Simple, clear                        |
| **Namespace**      | `donateraja`              | For Helm or k8s context              |
| **Secrets**        | `backend-secrets.yaml`    | Optional K8s sealed secrets          |
| **Env File**       | `.env.template`           | Populate with vars for both services |
| **Cluster Folder** | `environments/hostinger/` | Hostinger-specific overrides         |

---

### 🧠 Optional Script Names (for automation)

| Script                | Purpose                                       |
| --------------------- | --------------------------------------------- |
| `deploy-hostinger.sh` | Deploy both charts with `--values` override   |
| `upgrade-release.sh`  | Upgrade backend/frontend individually         |
| `delete-release.sh`   | Helm uninstall for cleanup                    |
| `test-connection.sh`  | (Optional) Curl endpoints or readiness checks |

---

### 🌐 Example Commands

```bash
# Install frontend
helm install dr-ui ./charts/frontend -f environments/hostinger/values-frontend.yaml

# Install backend
helm install dr-backend ./charts/backend -f environments/hostinger/values-backend.yaml
```

---

### 🔐 Example Secrets Strategy

If you plan to use K8s Secrets manually:

* `backend-secrets.yaml`: DB, JWT keys, etc.
* `frontend-secrets.yaml`: API base URL, sentry, etc.

Or you can use `Helm secrets` plugin, or SOPS + sealed-secrets if desired.

---

Would you like me to:

* Generate base Helm charts for frontend/backend?
* Add CI/CD GitHub Actions (build → push Docker → deploy Helm)?
* Help with configuring Hostinger Kubernetes access (if supported)?

Let me know what you want next and I’ll generate it.
