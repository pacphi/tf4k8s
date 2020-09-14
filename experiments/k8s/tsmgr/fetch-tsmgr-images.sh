#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Usage: fetch-tsmgr-images.sh {tanzu_network_username} {tanzu_network_password}"
	exit 1
fi

USERNAME="$1"
PASSWORD="$2"

VERSION=0.11.27

docker login -u "${USERNAME}" -p "${PASSWORD}" registry.pivotal.io
docker pull registry.pivotal.io/tanzu-service-manager/broker:${VERSION}
docker pull registry.pivotal.io/tanzu-service-manager/daemon:${VERSION}
docker pull registry.pivotal.io/tanzu-service-manager/minio:${VERSION}
docker pull registry.pivotal.io/tanzu-service-manager/chartmuseum:${VERSION}

