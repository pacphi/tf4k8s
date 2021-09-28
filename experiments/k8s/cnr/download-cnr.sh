#!/bin/bash

# This script requires docker and the pivnet CLI!


if [ -z "$1" ]; then
	echo "Usage: download-cnr.sh {pivnet-api-token} {install-carvel-tools-and-kubectl}"
	exit 1
fi

TANZU_NETWORK_API_TOKEN="$1"

pivnet login --api-token=$TANZU_NETWORK_API_TOKEN

cd /tmp
CNR_VERSION="1.0.2+build.81"
CNR_PRODUCT_FILE_ID=1027518
pivnet accept-eula --product-slug='serverless' --release-version="${CNR_VERSION}"
pivnet download-product-files --product-slug='serverless' --release-version="${CNR_VERSION}" --product-file-id=${CNR_PRODUCT_FILE_ID}
VERSION="${CNR_VERSION%%+*}"
tar -xvf cloud-native-runtimes-${VERSION}.tgz

cd cloud-native-runtimes
CNR_LOCK_PRODUCT_FILE_ID=1027517
pivnet download-product-files --product-slug='serverless' --release-version="${CNR_VERSION}" --product-file-id=${CNR_LOCK_PRODUCT_FILE_ID}
chmod +x ./bin/install.sh

INSTALL_OTHER_TOOLS=${2:false}

if [ "${INSTALL_OTHER_TOOLS}" = true ]; then
	curl -L https://carvel.dev/install.sh | sudo bash
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x kubectl
	sudo mv kubectl /usr/local/bin/kubectl
fi