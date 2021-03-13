#!/usr/bin/env bash

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Usage: download-tanzu-mysql.sh {tanzu-network-username} {tanzu-network-password}"
	exit 1
fi

TANZU_MYSQL_INSTALLATION_NAME="tanzu-mysql-for-kubernetes"
TANZU_MYSQL_INSTALLATION_VERSION="0.2.0"

TANZU_NETWORK_USERNAME="$1"
TANZU_NETWORK_PASSWORD="$2"

./auth-registry.sh registry.pivotal.io ${TANZU_NETWORK_USERNAME} ${TANZU_NETWORK_PASSWORD}

cd /tmp || exit
mkdir -p tanzu-mysql-install
cd tanzu-mysql-install || exit

export HELM_EXPERIMENTAL_OCI=1
echo ${TANZU_NETWORK_PASSWORD} | helm registry login registry.pivotal.io/${TANZU_MYSQL_INSTALLATION_NAME}/charts --username=${TANZU_NETWORK_USERNAME} --password-stdin

helm chart pull registry.pivotal.io/${TANZU_MYSQL_INSTALLATION_NAME}/tanzu-mysql-operator-chart:${TANZU_MYSQL_INSTALLATION_VERSION}
helm chart export registry.pivotal.io/${TANZU_MYSQL_INSTALLATION_NAME}/tanzu-mysql-operator-chart:${TANZU_MYSQL_INSTALLATION_VERSION}

docker pull registry.pivotal.io/${TANZU_MYSQL_INSTALLATION_NAME}/tanzu-mysql-operator:${TANZU_MYSQL_INSTALLATION_VERSION}
docker pull registry.pivotal.io/${TANZU_MYSQL_INSTALLATION_NAME}/tanzu-mysql-instance:${TANZU_MYSQL_INSTALLATION_VERSION}
