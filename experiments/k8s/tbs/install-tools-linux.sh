#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: install-tools-linux.sh {pivnet-api-token}"
	exit 1
fi

PIVNET_API_TOKEN="$1"
pivnet login --api-token=$PIVNET_API_TOKEN

VERSION="1.1.2"

KP_PRODUCT_FILE_ID=883031
pivnet download-product-files --product-slug='build-service' --release-version="${VERSION}" --product-file-id="${KP_PRODUCT_FILE_ID}"
mv kp-linux-* kp
chmod +x kp
sudo mv kp /usr/local/bin
