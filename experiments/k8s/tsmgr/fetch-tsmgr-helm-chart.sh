#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Usage: fetch-tsmgr-helm-chart.sh {tanzu_network_api_token}"
	exit 1
fi

PIVNET_API_TOKEN="$1"
pivnet login --api-token=$PIVNET_API_TOKEN

cd /tmp || exit
TSMGR_VERSION="0.11.8"
TSMGR_CHART_PRODUCT_FILE_ID=777777

pivnet download-product-files --product-slug='tanzu-service-manager' --release-version="${TSMGR_VERSION}" --product-file-id=${TSMGR_CHART_PRODUCT_FILE_ID}
tar xvf tsmgr-${TSMGR_VERSION}.tgz
