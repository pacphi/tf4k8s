#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: destroy-tas4k8s.sh {iaas}"
	exit 1
fi

IAAS="$1"

terraform destroy -auto-approve

cd "../../../modules/tas4k8s/acme/${IAAS}" || exit
terraform destroy -auto-approve
rm -Rf .terraform/ terraform.log terraform.tfstate terraform.tfstate.backup iaas.auto.tfvars

cd ../.. || exit
rm -f certs.auto.tfvars

cd ../../ytt-libs/tas4k8s || exit

rm -Rf vendor
