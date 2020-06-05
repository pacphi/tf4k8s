#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: create-cf4k8s.sh {iaas}"
	exit 1
fi

IAAS="$1"

terraform destroy -auto-approve

rm -f ../../../modules/cf4k8s/certs.auto.tfvars
rm -f ../../../modules/cf4k8s/templates/config.yml
rm -Rf  ../../../modules/cf4k8s/acme/$IAAS/.terraform ../../../modules/cf4k8s/acme/$IAAS/terraform.log ../../../modules/cf4k8s/acme/$IAAS/terraform.tfstate*
rm -Rf ../../../ytt-libs/cf4k8s/vendor
rm -f ../../../ytt-libs/cf4k8s/vendir.lock.yml

# rm -Rf ./terraform terraform.log terraform.tfstate* graph.svg