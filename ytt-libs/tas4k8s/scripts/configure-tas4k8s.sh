#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: configure-tas4k8s.sh {domain}"
	exit 1
fi

DOMAIN="$1"

# PATCH
# Overwrite the generate-values.sh script that's bundled in
# /tmp/tanzu-application-service/config/_deps/cf-for-k8s/hack
# with {tf4k8s_root}/modules/tas4k8s/scripts/seed-config.sh so that Terraform variables
# drive certain configuration parameters like the system_registry and cf_admin_password
cp -f scripts/seed-config.sh /tmp/tanzu-application-service/config/_deps/cf-for-k8s/hack/generate-values.sh

# Generate initial configuration values
mkdir -p /tmp/tanzu-application-service/configuration-values
YTT_LIB_DIR="${PWD}"
cd /tmp/tanzu-application-service || exit
./bin/generate-values.sh -d "${DOMAIN}" > /tmp/tanzu-application-service/configuration-values/deployment-values.yml
cd "${YTT_LIB_DIR}" || exit

# Copy config into place
mkdir -p vendor
cp -Rf /tmp/tanzu-application-service/config vendor
cp -Rf /tmp/tanzu-application-service/config-optional vendor
cp -Rf /tmp/tanzu-application-service/configuration-values vendor
