#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: configure-cf4k8s.sh {domain}"
	exit 1
fi

DOMAIN="$1"
TMP_DIR=/tmp/cf4k8s
VENDIR_DIR=vendor/github.com/cloudfoundry/cf-for-k8s

# PATCH #1
# Overwrite the generate-values.sh script so that Terraform variables
# drive certain configuration property values like cf_admin_password and nested configuration property values underneath app_registry
mv ${VENDIR_DIR}/hack/generate-values.sh ${VENDIR_DIR}/hack/generate-values.sh.original
cp -f scripts/generate-values.sh ${VENDIR_DIR}/hack/generate-values.sh

# Generate initial configuration values
rm -Rf ${TMP_DIR}
mkdir -p ${TMP_DIR}
${VENDIR_DIR}/hack/generate-values.sh -d "${DOMAIN}" > ${TMP_DIR}/cf-values.yml
