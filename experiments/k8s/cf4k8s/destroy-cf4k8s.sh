#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: destroy-cf4k8s.sh {iaas}"
	exit 1
fi

IAAS="$1"

terraform destroy -auto-approve

cd "../../../modules/cf4k8s/acme/${IAAS}" || exit
terraform destroy -auto-approve
rm -Rf .terraform/ terraform.log terraform.tfstate* iaas.auto.tfvars

cd ../.. || exit
rm -f certs.auto.tfvars
rm -f templates/config.yml

cd ../.. || exit
rm -Rf ytt-libs/cf4k8s/vendor
rm -f ytt-libs/cf4k8s/vendir.lock.yml
