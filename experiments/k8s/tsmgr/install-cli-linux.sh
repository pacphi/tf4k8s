#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: install-cli-linux.sh {tanzu-network-api-token}"
	exit 1
fi

PIVNET_API_TOKEN="$1"
pivnet login --api-token=$PIVNET_API_TOKEN

VERSION="0.11.27"

TSMGR_PRODUCT_FILE_ID=785222
pivnet download-product-files --product-slug='tanzu-service-manager' --release-version="${VERSION}" --product-file-id="${TSMGR_PRODUCT_FILE_ID}"
mv tsmgr-${VERSION}.linux tsmgr
chmod +x tsmgr
sudo mv tsmgr /usr/local/bin
