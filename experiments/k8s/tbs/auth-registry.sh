#!/bin/bash

# This script requires docker!

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: auth-registry.sh {image-registry} {image-registry-username} {image-registry-password}"
	exit 1
fi

IMAGE_REGISTRY="$1"
IMAGE_REGISTRY_USERNAME="$2"
IMAGE_REGISTRY_PASSWORD="$3"

docker login "${IMAGE_REGISTRY}" -u "${IMAGE_REGISTRY_USERNAME}" -p "${IMAGE_REGISTRY_PASSWORD}"
