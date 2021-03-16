#!/usr/bin/env bash

FILE="/tmp/rabbitmq-operator.tar"
if [ -f "$FILE" ]; then
    echo "$FILE already downloaded"
	exit 1
fi

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: download-tanzu-rabbitmq.sh {tanzu-network-api-token}"
	exit 1
fi

TANZU_NETWORK_API_TOKEN="$1"
TANZU_NETWORK_USERNAME="$2"
TANZU_NETWORK_PASSWORD="$3"

pivnet login --api-token=${TANZU_NETWORK_API_TOKEN}

cd /tmp || exit
TANZU_RABBITMQ_VERSION="1.0.0"

TANZU_RABBITMQ_PRODUCT_FILE_ID=866685
mkdir -p tanzu-rabbitmq-install
pivnet download-product-files --product-slug='p-rabbitmq-for-kubernetes' --release-version="${TANZU_RABBITMQ_VERSION}" --product-file-id="${TANZU_RABBITMQ_PRODUCT_FILE_ID}"
mv tanzu-rabbitMQ-for-kubernetes-${TANZU_RABBITMQ_VERSION}.tar rabbitmq-operator.tar
tar xvf rabbitmq-operator.tar -C tanzu-rabbitmq-install
