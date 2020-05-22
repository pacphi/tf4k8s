#!/bin/bash

FILE="build-service-bundle.tgz"
if [ -f "$FILE" ]; then
    echo "$FILE already downloaded"
	exit 1
fi

if [ -z "$1" ]; then
	echo "Usage: download-tbs.sh {pivnet-api-token}"
	exit 1
fi

PIVNET_API_TOKEN="$1"
pivnet login --api-token=$PIVNET_API_TOKEN

TBS_VERSION="0.1.0"
TBS_PRODUCT_FILE_ID=648378
pivnet download-product-files --product-slug='build-service' --release-version="${TBS_VERSION}" --product-file-id="${TBS_PRODUCT_FILE_ID}"
tar -xvf "build-service-${TBS_VERSION}.tgz" -C /tmp
