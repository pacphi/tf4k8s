#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: create-pivotal-csb.sh {iaas}"
	exit 1
fi

IAAS="$1"

cp terraform.tfvars "${IAAS}/gcp-csb.auto.tfvars"

cd "${IAAS}"

if [ $IAAS == "gcp" ]; then
    credentials=$(cat ${GOOGLE_APPLICATION_CREDENTIALS})
	project_id=$(cat ${GOOGLE_APPLICATION_CREDENTIALS} | jq .project_id | tr -d '"')
	suffix=$(cat ${GOOGLE_APPLICATION_CREDENTIALS} | jq .private_key_id | tr -d '"')
	cred_filename="~/.tf4k8s/gcp/${project_id}-${suffix}.json"
	rm -f "${cred_filename}"
	echo $credentials > "${cred_filename}"
	export TF_VAR_gcp_credentials="${cred_filename}"
	export TF_VAR_gcp_project="${project_id}"
fi

terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan
terraform apply -auto-approve
