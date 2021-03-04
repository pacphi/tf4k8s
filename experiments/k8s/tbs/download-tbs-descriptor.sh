#!/bin/bash

# This script requires docker and the pivnet CLI!

FILE="/tmp/descriptor.yaml"
if [ -f "$FILE" ]; then
    echo "$FILE already downloaded"
	exit 1
fi

if [ -z "$1" ]; then
	echo "Usage: download-tbs-descriptor.sh {pivnet-api-token}"
	exit 1
fi

PIVNET_API_TOKEN="$1"

pivnet login --api-token=$PIVNET_API_TOKEN

cd /tmp || exit
TBS_VERSION="100.0.73"
TBS_PRODUCT_FILE_ID=899699
pivnet accept-eula --product-slug='tbs-dependencies' --release-version="${TBS_VERSION}"
pivnet download-product-files --product-slug='tbs-dependencies' --release-version="${TBS_VERSION}" --product-file-id=${TBS_PRODUCT_FILE_ID}
mv descriptor-${TBS_VERSION}.yaml descriptor.yaml
