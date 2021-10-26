#!/bin/bash

# This script requires docker and the pivnet CLI!


if [ -z "$1" ]; then
	echo "Usage: download-tbs-descriptor.sh {pivnet-api-token}"
	exit 1
fi

TANZU_NETWORK_API_TOKEN="$1"

pivnet login --api-token=$TANZU_NETWORK_API_TOKEN

FILE="/tmp/descriptor.yaml"
if [ -f "$FILE" ]; then
    echo "$FILE already downloaded"
	exit 1
fi

TBS_DESCRIPTOR_VERSION="100.0.202"
TBS_PRODUCT_FILE_ID=1072502
pivnet accept-eula --product-slug='tbs-dependencies' --release-version="${TBS_DESCRIPTOR_VERSION}"
pivnet download-product-files --product-slug='tbs-dependencies' --release-version="${TBS_DESCRIPTOR_VERSION}" --product-file-id=${TBS_PRODUCT_FILE_ID}
mv descriptor-${TBS_DESCRIPTOR_VERSION}.yaml /tmp/descriptor.yaml

FILE="/tmp/windows-descriptor.yaml"
if [ -f "$FILE" ]; then
    echo "$FILE already downloaded"
	exit 1
fi

TBS_DESCRIPTOR_VERSION="100.0.18"
TBS_PRODUCT_FILE_ID=1072322
pivnet accept-eula --product-slug='tbs-dependencies-windows' --release-version="${TBS_DESCRIPTOR_VERSION}"
pivnet download-product-files --product-slug='tbs-dependencies-windows' --release-version="${TBS_DESCRIPTOR_VERSION}" --product-file-id=${TBS_PRODUCT_FILE_ID}
mv descriptor-${TBS_DESCRIPTOR_VERSION}.yaml /tmp/windows-descriptor.yaml
