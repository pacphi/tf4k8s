#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: install-tools-macos.sh {pivnet-api-token}"
	exit 1
fi

PIVNET_API_TOKEN="$1"
pivnet login --api-token=$PIVNET_API_TOKEN

VERSION="1.0.1"

PB_PRODUCT_FILE_ID=760687
pivnet download-product-files --product-slug='build-service' --release-version="${VERSION}" --product-file-id="${PB_PRODUCT_FILE_ID}"
mv kp-darwin-* kp
chmod +x kp
sudo mv kp /usr/local/bin
