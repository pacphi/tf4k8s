#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: relocate-images.sh {image-registry}"
	exit 1
fi

VERSION="0.1.0"
IMAGE_REGISTRY="$2"

duffle relocate -f "/tmp/build-service-${VERSION}.tgz" -m /tmp/relocated.json -p "${IMAGE_REGISTRY}"
