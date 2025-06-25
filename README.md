# deploy-scripts
This repo is used for deploying the frontend and backend using Helm charts and automation scripts.

---

## Folder Structure

```
deploy-scripts/
├── README.md
├── charts/
│   └── donateraja/
│       ├── Chart.yaml
│       ├── files/
│       │   ├── dev/
│       │   │   ├── application.yaml
│       │   │   ├── config.json
│       │   │   └── values-secret.yaml
│       │   └── prod/
│       │       ├── application.yaml
│       │       ├── config.json
│       │       └── values-secret.yaml
│       └── templates/
│           ├── backend/
│           ├── frontend/
│           └── nginx-ingress.yaml
├── deploy.sh
```

---

## Running Instructions

### 1. Prepare Your Config and Secrets
- Place your environment-specific config files in `charts/donateraja/files/dev/` or `charts/donateraja/files/prod/` (e.g., `application.yaml`, `config.json`).
- Fill in your secrets in `values-secret.yaml` inside the respective environment folder (do NOT commit real secrets to git).

### 2. Deploy to Dev or Prod

**Dev:**
```bash
bash deploy.sh dev
```

**Prod:**
```bash
bash deploy.sh prod
```

This will:
- Use the correct namespace (`dev` or `prod`)
- Use the corresponding config and secrets files from the environment folder
- Update the deployment with the latest config and secrets, overriding any config in the Docker image

### 3. How It Works
- The Docker image contains a default `application.yaml` (and/or `config.json`) for fallback/local use.
- When you deploy, Kubernetes mounts the environment-specific `application.yaml` and `config.json` from the appropriate folder, overriding the image's files.
- Secrets are injected as environment variables from the `values-secret.yaml` file in the same folder.
- The order of precedence is: Docker image < ConfigMap (env-specific file) < Kubernetes Secrets (env vars).

### 4. Access URLs
After deployment, the script will print the backend and frontend service URLs.

---

## Notes
- To switch config, just update the files in the appropriate environment folder and deploy again.
- Never commit real secrets to git. Use `.gitignore` to exclude all `values-secret.yaml` files.
- This structure keeps your dev and prod configs and secrets cleanly separated and easy to manage.
