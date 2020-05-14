#!/bin/bash

terraform destroy -auto-approve


SERVICE_ACCOUNT_NAME=terraform
PROJECT_ID=$(gcloud config get-value project)

gcloud iam service-accounts delete ${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com --quiet
