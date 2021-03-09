#!/usr/bin/env bash

FILE="/tmp/spring-cloud-gateway-k8s.tgz"
if [ -f "$FILE" ]; then
    echo "$FILE already downloaded"
	exit 1
fi

if [ -z "$1" ]; then
	echo "Usage: download-scg.sh {tanzu-network-api-token}"
	exit 1
fi

TANZU_NETWORK_API_TOKEN="$1"
pivnet login --api-token=${TANZU_NETWORK_API_TOKEN}

cd /tmp || exit
mkdir -p scg-install
SCG_VERSION="1.0.0"
SCG_PRODUCT_FILE_ID=891162
pivnet download-product-files --product-slug='spring-cloud-gateway-for-kubernetes' --release-version="${SCG_VERSION}" --product-file-id="${SCG_PRODUCT_FILE_ID}"
mv spring-cloud-gateway-k8s-${SCG_VERSION}.tgz spring-cloud-gateway-k8s.tgz
tar xvf spring-cloud-gateway-k8s.tgz -C scg-install
