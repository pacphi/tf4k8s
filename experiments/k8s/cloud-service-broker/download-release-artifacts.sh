#!/bin/bash

DOWNLOADS_DIR="dist"

mkdir -p ${DOWNLOADS_DIR}/aws
mkdir -p ${DOWNLOADS_DIR}/azure
mkdir -p ${DOWNLOADS_DIR}/gcp

RELEASE_VERSION=0.2.3
AZURE_BROKERPAK_VERSION=1.0.0-rc.35

git clone https://github.com/cloudfoundry-incubator/csb-brokerpak-aws ${DOWNLOADS_DIR}/aws
git clone https://github.com/cloudfoundry-incubator/csb-brokerpak-gcp ${DOWNLOADS_DIR}/gcp

curl -Lo ${DOWNLOADS_DIR}/cloud-service-broker https://github.com/cloudfoundry-incubator/cloud-service-broker/releases/download/${RELEASE_VERSION}/cloud-service-broker.linux

cd ${DOWNLOADS_DIR}
curl -Lo azure/azure-services.brokerpak https://github.com/cloudfoundry-incubator/cloud-service-broker/releases/download/${AZURE_RELEASE_VERSION}/azure-services-${AZURE_BROKERPAK_VERSION}.brokerpak
cp cloud-service-broker aws
cp cloud-service-broker azure
cp cloud-service-broker gcp
rm -f cloud-service-broker
cd aws
make
cd ../gcp
make