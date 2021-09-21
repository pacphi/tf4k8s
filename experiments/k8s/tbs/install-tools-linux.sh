#!/bin/bash
set -e

if [ -z "$1" ]; then
	echo "Usage: install-cli-linux.sh {tanzu-network-api-token} {install-carvel-tools-and-kubectl}"
	exit 1
fi

if ! command -v pivnet &> /dev/null
then
    echo "Downloading pivnet CLI..."
	curl -LO https://github.com/pivotal-cf/pivnet-cli/releases/download/v3.0.1/pivnet-linux-amd64-3.0.1
	chmod +x pivnet-linux-amd64-3.0.1
	sudo mv pivnet-linux-amd64-3.0.1 /usr/local/bin/pivnet
fi


TANZU_NETWORK_API_TOKEN="$1"
pivnet login --api-token=$TANZU_NETWORK_API_TOKEN

TBS_VERSION="1.2.2"

KP_PRODUCT_FILE_ID=1000629
pivnet download-product-files --product-slug='build-service' --release-version="${TBS_VERSION}" --product-file-id="${KP_PRODUCT_FILE_ID}"
mv kp-linux-* kp
chmod +x kp
sudo mv kp /usr/local/bin

INSTALL_OTHER_TOOLS=${2:false}

if [ "${INSTALL_OTHER_TOOLS}" = true ]; then
	curl -L https://carvel.dev/install.sh | sudo bash
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x kubectl
	sudo mv kubectl /usr/local/bin/kubectl
fi
