#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ]; then
	echo "Usage: install-tbs-integrated-with-harbor.sh {harbor-domain} {harbor-project} {harbor-username} {harbor-password}"
	exit 1
fi

BUILD_SERVICE_INSTALLATION_NAME="tanzu-build-service"
CLUSTER_NAME="tbs"
HARBOR_DOMAIN="$1"
HARBOR_PROJECT="$2"
IMAGE_REPO="${HARBOR_DOMAIN}/${HARBOR_PROJECT}/build-service"
HARBOR_USERNAME="$3"
HARBOR_PASSWORD="$4"
BUILDER_IMAGE_TAG="${IMAGE_REPO}/default-builder"

duffle install "${BUILD_SERVICE_INSTALLATION_NAME}" -c /tmp/credentials.yml  \
    --set kubernetes_env="${CLUSTER_NAME}" \
    --set docker_registry="${HARBOR_DOMAIN}" \
    --set docker_repository="${IMAGE_REPO}" \
    --set registry_username="${HARBOR_USERNAME}" \
    --set registry_password="${HARBOR_PASSWORD}" \
    --set custom_builder_image="${BUILDER_IMAGE_TAG}" \
    -f /tmp/build-service-0.1.0.tgz \
    -m /tmp/relocated.json
