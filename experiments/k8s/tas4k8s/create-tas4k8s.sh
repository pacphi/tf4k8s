#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Usage: create-tas4k8s.sh {iaas} {pivnet-api-token}"
	exit 1
fi

IAAS="$1"
PIVNET_API_TOKEN="$2"

# Make copy of iaas.auto.tfvars in modules/tas4k8s/acme/${IAAS}
cp -f iaas.auto.tfvars "../../../modules/tas4k8s/acme/${IAAS}"

cd ../../../ytt-libs/tas4k8s || exit

# Fetch specific release of VMWare Tanzu Application Service for Kubernetes from VMWare Tanzu Network
./scripts/download-tas4k8s.sh "${PIVNET_API_TOKEN}"

# Configure before installing
./scripts/configure-tas4k8s.sh

# Move .tar and extracted content to waste bin
./scripts/cleanup-tas4k8s.sh

cd ../../modules/tas4k8s || exit

# Generate certs.auto.tfvars encapsulating key-value pair configuration for system and workloads domain certificates
cd "acme/$IAAS" || exit
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
cd ../../../.. || exit

# Install
cd experiments/k8s/tas4k8s || exit
terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan
terraform apply -auto-approve
