#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ] && [ -z "$5" ] && [ -z "$6" ]; then
	echo "Usage: publish-container-image.sh {registry_domain} {registry_repository} {registry_username} {registry_password} {image} {tag}"
	exit 1
fi

REGISTRY_HOSTNAME="${1}"
REGISTRY_URL="https://${1}"
REGISTRY_REPOSITORY="${1}/${2}"
USERNAME="${3}"
PASSWORD="${4}"
IMAGE="${5}"
TAG="${6}"

docker login -u "${USERNAME}" -p "${PASSWORD}" "${REGISTRY_URL}"
docker tag "${IMAGE}:${TAG}" "${REGISTRY_REPOSITORY}/${IMAGE}:${TAG}"
docker push "${REGISTRY_REPOSITORY}/${IMAGE}:${TAG}"
