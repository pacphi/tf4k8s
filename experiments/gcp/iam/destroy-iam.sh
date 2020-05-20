#!/bin/bash

SERVICE_ACCOUNT_NAME=terraform

if [ -z "$1" ]; then
  SERVICE_ACCOUNT_NAME=terraform
  PROJECT_ID=$(gcloud config get-value project)

  gcloud projects remove-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role='roles/viewer'

  gcloud projects remove-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role='roles/iam.serviceAccountUser'

  gcloud projects remove-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role='roles/container.admin'

  gcloud projects remove-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role='roles/container.clusterAdmin'

  gcloud projects remove-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role='roles/container.developer'

  gcloud projects remove-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role='roles/dns.admin'

  gcloud iam service-accounts delete "${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" --quiet
else
  PROJECT_ID="$1"
  gcloud projects delete "$PROJECT_ID"
fi

rm -f /tmp/gcp-${SERVICE_ACCOUNT_NAME}-${PROJECT_ID}-service-account-credentials.json
