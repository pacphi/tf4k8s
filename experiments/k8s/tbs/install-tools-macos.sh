#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: install-tools-macos.sh {pivnet-api-token}"
	exit 1
fi

PIVNET_API_TOKEN="$1"
pivnet login --api-token=$PIVNET_API_TOKEN

VERSION="0.1.0"

PB_PRODUCT_FILE_ID=648384
pivnet download-product-files --product-slug='build-service' --release-version="${VERSION}" --product-file-id="${PB_PRODUCT_FILE_ID}"
mv pb-${VERSION}-darwin pb
chmod +x pb
sudo mv pb /usr/local/bin

PB_PRODUCT_FILE_ID=648381
pivnet download-product-files --product-slug='build-service' --release-version="${VERSION}" --product-file-id="${PB_PRODUCT_FILE_ID}"
mv duffle-${VERSION}-darwin duffle
chmod +x duffle
sudo mv duffle /usr/local/bin
