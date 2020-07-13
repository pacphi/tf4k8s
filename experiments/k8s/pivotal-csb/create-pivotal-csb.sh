#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: create-pivotal-csb.sh {iaas}"
	exit 1
fi

IAAS="$1"

cp terraform.tfvars "${IAAS}/csb.auto.tfvars"

cd "${IAAS}"

if [ $IAAS == "aws" ]; then
    credentials=$(cat ${HOME}/.aws/credentials)
	export TF_VAR_aws_credentials="${credentials}"
fi

if [ $IAAS == "gcp" ]; then
    credentials=$(cat ${GOOGLE_APPLICATION_CREDENTIALS})
	project_id=$(cat ${GOOGLE_APPLICATION_CREDENTIALS} | jq .project_id | tr -d '"')
	export TF_VAR_gcp_credentials="${credentials}"
	export TF_VAR_gcp_project="${project_id}"
fi

terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan
terraform apply -auto-approve
