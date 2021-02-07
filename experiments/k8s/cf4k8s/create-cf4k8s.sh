#!/bin/bash

PRODUCT_NAME=cf4k8s

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Usage: create-${PRODUCT_NAME}.sh {iaas} {domain}"
	exit 1
fi

IAAS="$1"
DOMAIN="cf.$2"

# Make copy of iaas.auto.tfvars in modules/${PRODUCT_NAME}/acme/${IAAS}
cp -f iaas.auto.tfvars "../../../modules/${PRODUCT_NAME}/acme/${IAAS}"

cd ../../../ytt-libs/${PRODUCT_NAME} || exit

# Fetch specific release (based on commit hash) of Cloud Foundry for Kubernetes from Github
./scripts/download-${PRODUCT_NAME}.sh

# Configure before installing
./scripts/configure-${PRODUCT_NAME}.sh "${DOMAIN}"

cd ../../modules/${PRODUCT_NAME} || exit

# Generate certs.auto.tfvars encapsulating key-value pair configuration for system and workloads domain certificates
cd "acme/$IAAS" || exit
terraform init
terraform validate
terraform plan -out terraform.plan
terraform apply -auto-approve -state terraform.tfstate terraform.plan
cd ../../../.. || exit

# Install
cd experiments/k8s/${PRODUCT_NAME} || exit
terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan -out terraform.plan
terraform apply -auto-approve -state terraform.tfstate terraform.plan
