#!/bin/bash

# This script requires docker and the pivnet CLI!

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: download-tbs-dependencies.sh {pivnet-api-token} {pivnet-username} {pivnet-password}"
	exit 1
fi

PIVNET_API_TOKEN="$1"
DOCKER_REGISTRY_USERNAME="$2"
DOCKER_REGISTRY_PASSWORD="$3"

pivnet login --api-token=$PIVNET_API_TOKEN

VERSION="2"
pivnet accept-eula --product-slug='tbs-dependencies' --release-version="${VERSION}"

docker login registry.pivotal.io -u "${DOCKER_REGISTRY_USERNAME}" -p "${DOCKER_REGISTRY_PASSWORD}"
docker pull registry.pivotal.io/tbs-dependencies/orgcloudfoundrydotnet-core:v0.0.6
docker pull registry.pivotal.io/tbs-dependencies/orgcloudfoundrynginx:0.0.25
docker pull registry.pivotal.io/tbs-dependencies/orgcloudfoundryhttpd:0.0.21
docker pull registry.pivotal.io/tbs-dependencies/orgcloudfoundryphp:v0.0.0-RC1
docker pull registry.pivotal.io/tbs-dependencies/orgcloudfoundrygo:v0.0.4
docker pull registry.pivotal.io/tbs-dependencies/orgcloudfoundrypython:v0.0.1
docker pull registry.pivotal.io/tbs-dependencies/iopivotalnodejs:v2.0.7
docker pull registry.pivotal.io/tbs-dependencies/iopivotaljava:v2.1.281
docker pull registry.pivotal.io/tbs-dependencies/build:1586272925
docker pull registry.pivotal.io/tbs-dependencies/run:1586272925
