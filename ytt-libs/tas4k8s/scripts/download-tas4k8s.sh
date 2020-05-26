#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: download-tas4k8s.sh {pivnet-api-token}"
	exit 1
fi

PIVNET_API_TOKEN="$1"
pivnet login --api-token=$PIVNET_API_TOKEN

TAS4K8S_VERSION="0.2.0-build.101"
TAS4K8S_PRODUCT_FILE_ID=692782
pivnet download-product-files --product-slug='tas-for-kubernetes' --release-version="${TAS4K8S_VERSION}" --product-file-id="${TAS4K8S_PRODUCT_FILE_ID}"
tar -xvf "tanzu-application-service.${TAS4K8S_VERSION}.tar" -C /tmp
mkdir -p vendor
mv /tmp/tanzu-application-service/config vendor
mv /tmp/tanzu-application-service/config-optional vendor
mv /tmp/tanzu-application-service/hack vendor
rm -f "tanzu-application-service.${TAS4K8S_VERSION}.tar"
rm -Rf /tmp/tanzu-application-service
