#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: relocate-images.sh {tanzu-network-username} {tanzu-network-password} {image-repository}"
	exit 1
fi

TBS_VERSION="1.2.2"
PIVNET_USERNAME="$1"
PIVNET_PASSWORD="$2"
IMAGE_REPOSITORY="$3"

docker login registry.pivotal.io -u "${PIVNET_USERNAME}" -p "${PIVNET_PASSWORD}"
imgpkg copy -b "registry.pivotal.io/build-service/bundle:${TBS_VERSION}" --to-repo ${IMAGE_REPOSITORY}
