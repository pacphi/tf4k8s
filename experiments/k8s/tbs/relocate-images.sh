#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: relocate-images.sh {tanzu-network-username} {tanzu-network-password} {image-repository}"
	exit 1
fi

PIVNET_USERNAME="$1"
PIVNET_PASSWORD="$2"
IMAGE_REPOSITORY="$3"

cd /tmp || exit
docker login registry.pivotal.io -u "${PIVNET_USERNAME}" -p "${PIVNET_PASSWORD}"
kbld relocate -f tbs-install/images.lock --lock-output tbs-install/images-relocated.lock --repository ${IMAGE_REPOSITORY}
