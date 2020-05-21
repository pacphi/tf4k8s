#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Usage: create-tas4k8s.sh {domain} {pivnet-api-token}"
	exit 1
fi

DOMAIN="tas.$1"
PIVNET_API_TOKEN="$2"

rm -f ../../../modules/tas4k8s/templates/config.yml
rm -f ../../../modules/tas4k8s/templates/kpack-webhook.yml
rm -Rf ../../../ytt-libs/tas4k8s/vendor

# Fetch specific commit from https://github.com/cloudfoundry/cf-for-k8s
# Enables external-dns
cd ../../../ytt-libs/tas4k8s || exit
vendir sync

# Fetch specific release from Tanzu Network
./scripts/download-tas4k8s.sh "${PIVNET_API_TOKEN}"
cd ../.. || exit

# Seed configuration using modified version of hack script
cd modules/tas4k8s || exit
cp -n templates/fragment.yml templates/config.yml
./scripts/seed-config.sh -d "${DOMAIN}" >> templates/config.yml
cd ../.. || exit
./ytt-libs/tas4k8s/vendor/hack/generate-values.sh > modules/tas4k8s/templates/kpack-webhook.yml

cd experiments/k8s/tas4k8s || exit
terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan
terraform apply -auto-approve