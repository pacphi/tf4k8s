#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: destroy-tas4k8s.sh {iaas}"
	exit 1
fi

IAAS="$1"

# Manually uninstall the Postgres service instance before delegating to terraform destroy
# This is done because Helm will not automatically remove the persistent volume claim
helm uninstall pgsqlcfdb -n postgres-dbms
kubectl delete pvc -n postgres-dbms postgres-pvc --force
kubectl delete ns postgres-dbms

terraform destroy -auto-approve

cd "../../../modules/tas4k8s/acme/${IAAS}" || exit
terraform destroy -auto-approve
rm -Rf .terraform/ terraform.log terraform.tfstate terraform.tfstate.backup iaas.auto.tfvars

cd ../.. || exit
rm -f certs.auto.tfvars

cd ../../ytt-libs/tas4k8s || exit

rm -Rf vendor
