#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: relocate-images.sh {tanzu-network-username} {tanzu-network-password} {image-repository}"
	exit 1
fi

VERSION=1.0.2
PIVNET_USERNAME="$1"
PIVNET_PASSWORD="$2"
IMAGE_REPOSITORY="$3"

docker login registry.pivotal.io -u "${PIVNET_USERNAME}" -p "${PIVNET_PASSWORD}"

LOCK_INPUT=/tmp/cloud-native-runtimes/cloud-native-runtimes-${VERSION}.lock
LOCK_OUTPUT=/tmp/cloud-native-runtimes/relocated.lock
imgpkg copy --lock ${LOCK_INPUT} --to-repo ${IMAGE_REPOSITORY} --lock-output ${LOCK-OUTPUT} --registry-verify-certs=false
imgpkg pull --lock ${LOCK-OUTPUT} -o /tmp/cloud-native-runtimes --registry-verify-certs=false
