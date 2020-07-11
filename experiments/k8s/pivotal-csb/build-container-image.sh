#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: build-container-image.sh {iaas}"
	exit 1
fi

IAAS="$1"
ARTIFACT_DIR="dist/${IAAS}"

VERSION=$(cat ${ARTIFACT_DIR}/version)

docker build -t pivotal/cloud-service-broker:${VERSION} .