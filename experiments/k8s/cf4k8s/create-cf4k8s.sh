#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: create-cf4k8s.sh {domain}"
	exit 1
fi

DOMAIN="cf.$1"

rm -f ../../../modules/cf4k8s/templates/config.yml
rm -Rf ../../../ytt-libs/cf4k8s/vendor
rm -f ../../../ytt-libs/cf4k8s/vendir.lock.yml

# Fetch specific commit from https://github.com/cloudfoundry/cf-for-k8s
cd ../../../ytt-libs/cf4k8s || exit
vendir sync

# Seed configuration using modified version of hack script
cd ../../modules/cf4k8s || exit
cp -n templates/fragment.yml templates/config.yml
./scripts/seed-config.sh -d "${DOMAIN}" >> templates/config.yml
cd ../.. || exit

cd experiments/k8s/cf4k8s || exit
terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan
terraform apply -auto-approve