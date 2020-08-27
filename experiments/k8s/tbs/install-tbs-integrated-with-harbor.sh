#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ]; then
	echo "Usage: install-tbs-integrated-with-harbor.sh {harbor-domain} {harbor-project} {harbor-username} {harbor-password}"
	exit 1
fi

BUILD_SERVICE_INSTALLATION_NAME="tanzu-build-service"
HARBOR_DOMAIN="$1"
HARBOR_PROJECT="$2"
IMAGE_REPO="${HARBOR_DOMAIN}/${HARBOR_PROJECT}/build-service"
HARBOR_USERNAME="$3"
HARBOR_PASSWORD="$4"

cd /tmp || exit

ytt -f tbs-install/values.yaml \
    -f tbs-install/manifests/ \
    -v docker_repository="${IMAGE_REPO}" \
    -v docker_username="${HARBOR_USERNAME}" \
    -v docker_password="${HARBOR_PASSWORD}" \
    | kbld -f tbs-install/images-relocated.lock -f- \
    | kapp deploy -a ${BUILD_SERVICE_INSTALLATION_NAME} -f- -y

kp import -f descriptor.yaml
