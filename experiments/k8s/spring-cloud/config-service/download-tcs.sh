#!/usr/bin/env bash

FILE="/tmp/tanzu-configuration-service.tgz"
if [ -f "$FILE" ]; then
    echo "$FILE already downloaded"
	exit 1
fi

if [ -z "$1" ]; then
	echo "Usage: download-tcs.sh {tanzu-network-api-token}"
	exit 1
fi

PIVNET_API_TOKEN="$1"
pivnet login --api-token=${TANZU_NETWORK_API_TOKEN}

cd /tmp || exit
mkdir -p tcs-install
TCS_VERSION="v1.0.0-alpha.1"
TCS_PRODUCT_FILE_ID=893866
pivnet download-product-files --product-slug='application-configuration-service-for-vmware-tanzu' --release-version="${TCS_VERSION}" --product-file-id="${TCS_PRODUCT_FILE_ID}"
mv tanzu-configuration-service-${TCS_VERSION}.tgz tanzu-configuration-service.tgz
tar xvf tanzu-configuration-service.tgz -C tcs-install