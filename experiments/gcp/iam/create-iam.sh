#!/bin/bash

set -e

# We will only create a new project when we DO NOT pass an argument to this script

if [ -z "$1" ]; then

  RANDOM_ID=$RANDOM
  PROJECT_NAME=terraform-gke-$RANDOM_ID

# Create project

gcloud projects create $PROJECT_NAME --name="Terraform Kubernetes GKE" \
  --labels=type=gke

## List your projects

gcloud projects list

else

  PROJECT_NAME=$1

fi


## Set the project in gcloud

gcloud config set project $PROJECT_NAME

# Enable IAM, Compute, Container, and Container Registry APIs

gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable containerregistry.googleapis.com

# Create Service Account for Terraform
SERVICE_ACCOUNT_NAME=terraform
PROJECT_ID=$(gcloud config get-value project)
gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME \
  --description "Deploys IaC with Terraform" \
  --display-name "terraform"

# Set Service account permissions

## Give the Service account Kubernetes Engine Admin rights (be aware that this role gives you FULL Kubernetes Engine permissions!)

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --role='roles/viewer'

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --role='roles/iam.serviceAccountUser'

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --role='roles/container.admin'

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --role='roles/container.clusterAdmin'

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --role='roles/container.developer'

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --role='roles/dns.admin'

# Create Service account JSON key file

gcloud iam service-accounts keys create \
  --iam-account "${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
  /tmp/gcp/${SERVICE_ACCOUNT_NAME}-${PROJECT_ID}-service-account-credentials.json

echo "Find your new service account credentials here [ /tmp/gcp/${SERVICE_ACCOUNT_NAME}-${PROJECT_ID}-service-account-credentials.json ]"
