#!/bin/bash
set -e

if [ -z "$1" ]; then
	echo "Usage: install-tools-linux.sh {pivnet-api-token}"
	exit 1
fi

curl -LO https://github.com/pivotal-cf/pivnet-cli/releases/download/v3.0.1/pivnet-linux-amd64-3.0.1
chmod +x pivnet-linux-amd64-3.0.1
sudo mv pivnet-linux-amd64-3.0.1 /usr/local/bin/pivnet



PIVNET_API_TOKEN="$1"
pivnet login --api-token=$PIVNET_API_TOKEN

VERSION="1.1.3"

KP_PRODUCT_FILE_ID=883031
pivnet download-product-files --product-slug='build-service' --release-version="${VERSION}" --product-file-id="${KP_PRODUCT_FILE_ID}"
mv kp-linux-* kp
chmod +x kp
sudo mv kp /usr/local/bin

curl -L https://carvel.dev/install.sh | sudo bash