#!/bin/bash

set -e

CHART_PATH="charts/donateraja"
RELEASE_NAME="donateraja"
NAMESPACE=${1:-dev}  # default to 'dev' if not specified
VALUES_FILE="charts/donateraja/files/$NAMESPACE/values.yaml"
SECRETS_FILE="charts/donateraja/files/$NAMESPACE/values-secret.yaml"

# Optional: Uncomment to delete the release before upgrade for a clean slate
# helm uninstall $RELEASE_NAME -n $NAMESPACE || true

# Deploy the Helm chart with environment-specific values and secrets
helm upgrade --install $RELEASE_NAME $CHART_PATH \
  -n $NAMESPACE --create-namespace \
  -f $VALUES_FILE -f $SECRETS_FILE

echo "Deployment started. Checking service URLs..."

# Wait for services to be ready
kubectl rollout status deployment/donateraja-backend -n $NAMESPACE
kubectl rollout status deployment/donateraja-frontend -n $NAMESPACE

BACKEND_URL=$(kubectl get svc donateraja-backend -n $NAMESPACE -o jsonpath='http://{.status.loadBalancer.ingress[0].ip}:8080')
FRONTEND_URL=$(kubectl get svc donateraja-frontend -n $NAMESPACE -o jsonpath='http://{.status.loadBalancer.ingress[0].ip}')

echo "Backend URL: $BACKEND_URL"
echo "Frontend URL: $FRONTEND_URL"
