#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: download-tas4k8s.sh {pivnet-api-token}"
	exit 1
fi

PIVNET_API_TOKEN="$1"
pivnet login --api-token="${PIVNET_API_TOKEN}"

# Download and extract
TAS4K8S_VERSION="0.3.0-build.104"
TAS4K8S_PRODUCT_FILE_ID=731145
pivnet download-product-files --product-slug='tas-for-kubernetes' --release-version="${TAS4K8S_VERSION}" --product-file-id="${TAS4K8S_PRODUCT_FILE_ID}" --accept-eula
FILENAME=$(find . -type f -name "tanzu-application-service.*" -print | head -n 1)
tar -xvf "$FILENAME" -C /tmp
