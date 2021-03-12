#!/usr/bin/env bash

FILE="/tmp/postgres-for-kubernetes.tar.gz"
if [ -f "$FILE" ]; then
    echo "$FILE already downloaded"
	exit 1
fi

if [ -z "$1" ]; then
	echo "Usage: download-tanzu-postgres.sh {tanzu-network-api-token}"
	exit 1
fi

TANZU_NETWORK_API_TOKEN="$1"
pivnet login --api-token=${TANZU_NETWORK_API_TOKEN}

cd /tmp || exit
mkdir -p tanzu-postgres-install
TANZU_POSTGRES_VERSION="1.1.0"
TANZU_POSTGRES_PRODUCT_FILE_ID=893946
pivnet download-product-files --product-slug='tanzu-sql-postgres' --release-version="${TANZU_POSTGRES_VERSION}" --product-file-id="${TANZU_POSTGRES_PRODUCT_FILE_ID}"
mv postgres-for-kubernetes-v${TANZU_POSTGRES_VERSION}.tar.gz postgres-for-kubernetes.tar.gz
tar xvf postgres-for-kubernetes.tar.gz -C tanzu-postgres-install
