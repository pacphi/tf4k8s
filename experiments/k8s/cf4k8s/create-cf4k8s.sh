#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Usage: create-cf4k8s.sh {iaas} {domain}"
	exit 1
fi

IAAS="$1"
DOMAIN="cf.$2"

rm -f ../../../modules/cf4k8s/templates/config.yml
rm -Rf ../../../ytt-libs/cf4k8s/vendor
rm -f ../../../ytt-libs/cf4k8s/vendir.lock.yml

# Make copy of iaas.auto.tfvars in modules/cf4k8s/acme/${IAAS}
cp -f iaas.auto.tfvars "../../../modules/cf4k8s/acme/${IAAS}"

# Fetch specific commit from https://github.com/cloudfoundry/cf-for-k8s
cd ../../../ytt-libs/cf4k8s || exit
vendir sync
# Copy config-optional/use-external-dns-for-wildcard.yml into config
cp -f config-optional/use-external-dns-for-wildcard.yml config

# Seed configuration using modified version of hack script
cd ../../modules/cf4k8s || exit

# Generate certs.auto.tfvars encapsulating key-value pair configuration for system and workloads domain certificates
cd "acme/$IAAS" || exit
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
cd ../.. || exit

cp -n templates/fragment.yml templates/config.yml
./scripts/seed-config.sh -d "${DOMAIN}" >> templates/config.yml
cd ../.. || exit

cd experiments/k8s/cf4k8s || exit
terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan
terraform apply -auto-approve