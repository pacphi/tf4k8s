#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: configure-tas4k8s.sh {domain}"
	exit 1
fi

DOMAIN="$1"

# PATCH #1
# Overwrite the generate-values.sh script that's bundled in
# /tmp/tanzu-application-service/config/_ytt_lib/github.com/cloudfoundry/cf-for-k8s/hack
# with {tf4k8s_root}/modules/tas4k8s/scripts/seed-config.sh so that Terraform variables
# drive certain configuration parameters like the system_registry and cf_admin_password
cp -f scripts/seed-config.sh /tmp/tanzu-application-service/config/_ytt_lib/github.com/cloudfoundry/cf-for-k8s/hack/generate-values.sh

# Generate initial configuration values
mkdir -p /tmp/tanzu-application-service/configuration-values
YTT_LIB_DIR="${PWD}"
cd /tmp/tanzu-application-service || exit
./bin/generate-values.sh -d "${DOMAIN}" > /tmp/tanzu-application-service/configuration-values/deployment-values.tmp
cd "${YTT_LIB_DIR}" || exit

# Copy config into place
mkdir -p vendor
cp -Rf /tmp/tanzu-application-service/config vendor
cp -Rf /tmp/tanzu-application-service/config-optional vendor
cp -Rf /tmp/tanzu-application-service/configuration-values vendor

# PATCH #2
# Note: ytt 0.28.0 introduces the ability to target a data/values file at a library.
# tanzu-application-service now consumes cf-for-k8s as a library and takes advantage of that ytt feature
# in https://github.com/pivotal/tanzu-application-service/commit/747c717ebabc4844357241a4bf58290390bdedfd#diff-4ea4a837e2e8d9f061110d2bfa1a2f27
# With that change, a TAS operator is expected to configure cf-for-k8s explicitly (via a data/value file annotated with @library/ref).

# However, if we want to supply additional configuration to cf-for-k8s we need to copy that into place within the library directory.
# Since TAS releases do not package https://github.com/cloudfoundry/cf-for-k8s/tree/master/config-optional, earlier we had to vendir
# that directory and copy one or more file into place. In this case, we're integrating external-dns with Istio ingress.

cp -f vendor/config-optional/use-external-dns-for-wildcard.yml vendor/config/_ytt_lib/github.com/cloudfoundry/cf-for-k8s/config

# If deploying tas4k8s to a kind cluster then
# include the remove-resource-requirements.yml, remove-ingressgateway-service.yml, add-metrics-server-components.yml 
# and patch-metrics-server.yml overlay files in the set of templates to be deployed
if [ ! -z "$IS_KIND" ]; then
  cp -f vendor/config-optional/remove-resource-requirements.yml vendor/config/_ytt_lib/github.com/cloudfoundry/cf-for-k8s/config
  cp -f vendor/config-optional/remove-ingressgateway-service.yml vendor/config/_ytt_lib/github.com/cloudfoundry/cf-for-k8s/config
  cp -f vendor/config-optional/add-metrics-server-components.yml vendor/config/_ytt_lib/github.com/cloudfoundry/cf-for-k8s/config
  cp -f vendor/config-optional/patch-metrics-server.yml vendor/config/_ytt_lib/github.com/cloudfoundry/cf-for-k8s/config
fi
