#!/bin/bash

FILE="/tmp/build-service.tar"
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

cd /tmp || exit
mkdir -p tbs-install
TBS_VERSION="1.1.3"
TBS_PRODUCT_FILE_ID=899754
pivnet download-product-files --product-slug='build-service' --release-version="${TBS_VERSION}" --product-file-id="${TBS_PRODUCT_FILE_ID}"
mv build-service-${TBS_VERSION}.tar build-service.tar
tar xvf build-service.tar -C tbs-install
