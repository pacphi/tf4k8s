#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: destroy-pivotal-csb.sh {iaas}"
	exit 1
fi

IAAS="$1"

cd "${IAAS}"

if [ $IAAS == "gcp" ]; then
    credentials=$(cat ${GOOGLE_APPLICATION_CREDENTIALS})
	project_id=$(cat ${GOOGLE_APPLICATION_CREDENTIALS} | jq .project_id | tr -d '"')
	suffix=$(cat ${GOOGLE_APPLICATION_CREDENTIALS} | jq .private_key_id | tr -d '"')
	cred_filename="~/.tf4k8s/gcp/${project_id}-${suffix}.json"
    export TF_VAR_gcp_project="${project_id}"
	rm -f "${cred_filename}"
	echo $credentials > "${cred_filename}"
	export TF_VAR_gcp_credentials="${cred_filename}"
fi

terraform destroy -auto-approve
