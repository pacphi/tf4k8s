#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: destroy-pivotal-csb.sh {iaas}"
	exit 1
fi

IAAS="$1"

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

terraform destroy -auto-approve
rm -Rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup terraform.log terraform.plan graph.svg
