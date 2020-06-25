#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: create-tas4k8s.sh {iaas} {domain} {pivnet-api-token}"
	exit 1
fi

IAAS="$1"
DOMAIN="tas.$2"
PIVNET_API_TOKEN="$3"

rm -Rf ../../../ytt-libs/tas4k8s/vendor
rm -Rf ../../../ytt-libs/tas4k8s/vendir.lock.yml

# Make copy of iaas.auto.tfvars in modules/tas4k8s/acme/${IAAS}
cp -f iaas.auto.tfvars "../../../modules/tas4k8s/acme/${IAAS}"

# Fetch specific commit from https://github.com/cloudfoundry/cf-for-k8s
# Enables external-dns
cd ../../../ytt-libs/tas4k8s || exit
vendir sync

# Fetch specific release of VMWare Tanzu Application Service for Kuberenetes from VMWare Tanzu Network
./scripts/download-tas4k8s.sh "${PIVNET_API_TOKEN}"

# Configure before installing
./scripts/configure-tas4k8s.sh "${DOMAIN}"

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
