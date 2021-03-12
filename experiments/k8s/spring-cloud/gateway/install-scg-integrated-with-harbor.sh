#!/usr/bin/env bash

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Usage: install-scg-integrated-with-harbor.sh {harbor-domain} {harbor-project}"
	exit 1
fi

VERSION="1.0.0"
SPRING_CLOUD_GATEWAY_INSTALLATION_NAME="spring-cloud-gateway-k8s-${VERSION}"
HARBOR_DOMAIN="$1"
HARBOR_PROJECT="$2"
IMAGE_REPO="${HARBOR_DOMAIN}/${HARBOR_PROJECT}/spring-cloud-gateway"

cd /tmp/scg-install/${SPRING_CLOUD_GATEWAY_INSTALLATION_NAME} || exit

./scripts/relocate-images.sh ${IMAGE_REPO}
./scripts/install-spring-cloud-gateway.sh
