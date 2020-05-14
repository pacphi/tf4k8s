#!/bin/bash

set -e

# We will only create a new project when we DO NOT pass an argument to this script

if [ -z "$1" ]; then

  RANDOM_ID=$RANDOM
  PROJECT_NAME=terraform-k8s-$RANDOM_ID

# Create project

gcloud projects create $PROJECT_NAME --name="Terraform Kubernetes GKE" \
  --labels=type=k8s

## List your projects

gcloud projects list

else

  PROJECT_NAME=$1

fi


## Set the project in gcloud

gcloud config set project $PROJECT_NAME

# Enable Compute, Container, and Container Registry APIs

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

# Create Service account JSON key file

gcloud iam service-accounts keys create \
  --iam-account "${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
  account.json
