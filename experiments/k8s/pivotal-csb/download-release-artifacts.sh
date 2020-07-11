#!/bin/bash

DOWNLOADS_DIR="dist"

mkdir -p ${DOWNLOADS_DIR}/aws
mkdir -p ${DOWNLOADS_DIR}/azure
mkdir -p ${DOWNLOADS_DIR}/gcp

curl -Lo ${DOWNLOADS_DIR}/aws/cloud-service-broker https://github.com/pivotal/cloud-service-broker/releases/download/sb-0.1.0-rc.31-aws-0.0.1-rc.105/cloud-service-broker
curl -Lo ${DOWNLOADS_DIR}/azure/cloud-service-broker https://github.com/pivotal/cloud-service-broker/releases/download/sb-0.1.0-rc.31-azure-0.0.1-rc.102/cloud-service-broker
curl -Lo ${DOWNLOADS_DIR}/gcp/cloud-service-broker https://github.com/pivotal/cloud-service-broker/releases/download/sb-0.1.0-rc.31-gcp-0.0.1-rc.71/cloud-service-broker

curl -Lo ${DOWNLOADS_DIR}/aws/aws-services.brokerpak https://github.com/pivotal/cloud-service-broker/releases/download/sb-0.1.0-rc.31-aws-0.0.1-rc.105/aws-services-0.0.1-rc.105.brokerpak
curl -Lo ${DOWNLOADS_DIR}/azure/azure-services.brokerpak https://github.com/pivotal/cloud-service-broker/releases/download/sb-0.1.0-rc.31-azure-0.0.1-rc.102/azure-services-0.0.1-rc.102.brokerpak
curl -Lo ${DOWNLOADS_DIR}/gcp/gcp-services.brokerpak https://github.com/pivotal/cloud-service-broker/releases/download/sb-0.1.0-rc.31-gcp-0.0.1-rc.71/google-services-0.0.1-rc.71.brokerpak

curl -Lo ${DOWNLOADS_DIR}/aws/version https://github.com/pivotal/cloud-service-broker/releases/download/sb-0.1.0-rc.31-aws-0.0.1-rc.105/version
curl -Lo ${DOWNLOADS_DIR}/azure/version https://github.com/pivotal/cloud-service-broker/releases/download/sb-0.1.0-rc.31-azure-0.0.1-rc.102/version
curl -Lo ${DOWNLOADS_DIR}/gcp/version https://github.com/pivotal/cloud-service-broker/releases/download/sb-0.1.0-rc.31-gcp-0.0.1-rc.71/version