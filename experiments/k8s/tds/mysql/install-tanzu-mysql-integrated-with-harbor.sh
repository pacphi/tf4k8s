#!/usr/bin/env bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ]; then
	echo "Usage: install-tanzu-mysql-integrated-with-harbor.sh {harbor-domain} {harbor-project} {harbor-username} {harbor-password}"
	exit 1
fi

TANZU_MYSQL_INSTALLATION_NAME="tanzu-mysql-for-kubernetes"
TANZU_MYSQL_INSTALLATION_VERSION="0.2.0"
HARBOR_DOMAIN="$1"
HARBOR_PROJECT="$2"
HARBOR_USERNAME="$3"
HARBOR_PASSWORD="$4"
IMAGE_REPO="${HARBOR_DOMAIN}/${HARBOR_PROJECT}/mysql"

./auth-registry.sh ${HARBOR_DOMAIN} ${HARBOR_USERNAME} ${HARBOR_PASSWORD}

docker tag registry.pivotal.io/${TANZU_MYSQL_INSTALLATION_NAME}/tanzu-mysql-operator:${TANZU_MYSQL_INSTALLATION_VERSION} ${IMAGE_REPO}/mysql-operator:${TANZU_MYSQL_INSTALLATION_VERSION}
docker tag registry.pivotal.io/${TANZU_MYSQL_INSTALLATION_NAME}/tanzu-mysql-instance:${TANZU_MYSQL_INSTALLATION_VERSION} ${IMAGE_REPO}/mysql-instance:${TANZU_MYSQL_INSTALLATION_VERSION}

docker push ${IMAGE_REPO}/mysql-instance:${TANZU_MYSQL_INSTALLATION_VERSION}
docker push ${IMAGE_REPO}/mysql-operator:${TANZU_MYSQL_INSTALLATION_VERSION}

NAMESPACE="${TANZU_MYSQL_INSTALLATION_NAME}-system"
kubectl create namespace ${NAMESPACE}

kapp deploy -a mysql-operator -y \
-f <(kubectl create secret docker-registry mysql-harbor \
-n ${NAMESPACE} \
--docker-server="${HARBOR_DOMAIN}" \
--docker-username="${HARBOR_USERNAME}" \
--docker-password="${HARBOR_PASSWORD}" \
--dry-run=client \
-o yaml)

cd /tmp/tanzu-mysql-install || exit

helm upgrade --install mysql-operator \
--namespace ${NAMESPACE} \
--cleanup-on-fail \
./tanzu-mysql-operator \
--atomic \
--set operatorImage="${IMAGE_REPO}/mysql-operator:${TANZU_MYSQL_INSTALLATION_VERSION}" \
--set tanzuMySQLImage="${IMAGE_REPO}/mysql-instance:${TANZU_MYSQL_INSTALLATION_VERSION}" \
--set imagePullSecret="mysql-harbor"
