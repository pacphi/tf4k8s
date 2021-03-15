#!/usr/bin/env bash

FILE="/tmp/gemfire-operator.tgz"
if [ -f "$FILE" ]; then
    echo "$FILE already downloaded"
	exit 1
fi

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: download-tanzu-gemfire.sh {tanzu-network-api-token} {tanzu-network-username} {tanzu-network-password}"
	exit 1
fi

TANZU_NETWORK_API_TOKEN="$1"
TANZU_NETWORK_USERNAME="$2"
TANZU_NETWORK_PASSWORD="$3"

pivnet login --api-token=${TANZU_NETWORK_API_TOKEN}
./auth-registry.sh registry.pivotal.io ${TANZU_NETWORK_USERNAME} ${TANZU_NETWORK_PASSWORD}

cd /tmp || exit
TANZU_GEMFIRE_VERSION="1.0.0"

docker pull registry.pivotal.io/tanzu-gemfire-for-kubernetes/gemfire-controller:${TANZU_GEMFIRE_VERSION}
docker pull registry.pivotal.io/tanzu-gemfire-for-kubernetes/gemfire-k8s:${TANZU_GEMFIRE_VERSION}

TANZU_GEMFIRE_PRODUCT_FILE_ID=840400
mkdir -p tanzu-gemfire-install
pivnet download-product-files --product-slug='tanzu-gemfire-for-kubernetes' --release-version="${TANZU_GEMFIRE_VERSION}" --product-file-id="${TANZU_GEMFIRE_PRODUCT_FILE_ID}"
mv gemfire-operator-${TANZU_GEMFIRE_VERSION}.tgz gemfire-operator.tgz
tar xvf gemfire-operator.tgz -C tanzu-gemfire-install

GFSH_VERSION="9.10.6"
GFSH_PRODUCT_FILE_ID=891272
pivnet download-product-files --product-slug='pivotal-gemfire' --release-version="${GFSH_VERSION}" --product-file-id="${GFSH_PRODUCT_FILE_ID}"
tar xvf pivotal-gemfire-${GFSH_VERSION}.tgz
