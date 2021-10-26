#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ] && [ -z "$5" ] && [ -z "$6" ]; then
	echo "Usage: install-tbs-integrated-with-harbor.sh {harbor-domain} {harbor-project} {harbor-username} {harbor-password} {tanzu-network-username} {tanzu-network-password} {registry-ca-cert-path}"
	exit 1
fi

TBS_VERSION="1.3.1"
PATH_TO_CA_CERT=${7:-}
BUILD_SERVICE_INSTALLATION_NAME="tanzu-build-service"
HARBOR_DOMAIN="$1"
HARBOR_PROJECT="$2"
IMAGE_REPO="${HARBOR_DOMAIN}/${HARBOR_PROJECT}/build-service"
HARBOR_USERNAME="$3"
HARBOR_PASSWORD="$4"
TANZU_NETWORK_USERNAME="$5"
TANZU_NETWORK_PASSWORD="$6"

imgpkg pull -b "${IMAGE_REPO}:${TBS_VERSION}" -o /tmp/bundle

if [ -z "${PATH_TO_CA_CERT}" ]; then
    echo "No CA cert assuming public trusted cert on registry"
    ytt -f /tmp/bundle/values.yaml \
        -f /tmp/bundle/config/ \
        -v docker_repository="${IMAGE_REPO}" \
        -v docker_username="${HARBOR_USERNAME}" \
        -v docker_password="${HARBOR_PASSWORD}" \
        -v tanzunet_username="${TANZU_NETWORK_USERNAME}" \
        -v tanzunet_password="${TANZU_NETWORK_PASSWORD}" \
        | kbld -f /tmp/bundle/.imgpkg/images.yml -f- \
        | kapp deploy -a ${BUILD_SERVICE_INSTALLATION_NAME} -f- -y

    kp import -f /tmp/descriptor.yaml
    kp import -f /tmp/windows-descriptor.yaml

else
    echo "CA cert passed"
    ytt -f /tmp/bundle/values.yaml \
        -f /tmp/bundle/config/ \
        -f ${PATH_TO_CA_CERT} \
        -v docker_repository="${IMAGE_REPO}" \
        -v docker_username="${HARBOR_USERNAME}" \
        -v docker_password="${HARBOR_PASSWORD}" \
        -v tanzunet_username="${TANZU_NETWORK_USERNAME}" \
        -v tanzunet_password="${TANZU_NETWORK_PASSWORD}" \
        | kbld -f /tmp/bundle/.imgpkg/images.yml -f- \
        | kapp deploy -a ${BUILD_SERVICE_INSTALLATION_NAME} -f- -y

    kp import -f /tmp/descriptor.yaml --registry-ca-cert-path ${PATH_TO_CA_CERT}
    kp import -f /tmp/windows-descriptor.yaml --registry-ca-cert-path ${PATH_TO_CA_CERT}

fi