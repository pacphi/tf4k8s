#!/usr/bin/env bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ]; then
	echo "Usage: install-tanzu-postgres-integrated-with-harbor.sh {harbor-domain} {harbor-project} {harbor-username} {harbor-password}"
	exit 1
fi

VERSION="1.1.0"
TANZU_POSTGRES_INSTALLATION_NAME="postgres-for-kubernetes-v${VERSION}"
HARBOR_DOMAIN="$1"
HARBOR_PROJECT="$2"
HARBOR_USERNAME="$3"
HARBOR_PASSWORD="$4"
IMAGE_REPO="${HARBOR_DOMAIN}/${HARBOR_PROJECT}/postgres"

cd /tmp/tanzu-postgres-install/${TANZU_POSTGRES_INSTALLATION_NAME} || exit

docker load -i ./images/postgres-operator
docker load -i ./images/postgres-instance
docker images "postgres-*"

docker tag postgres-operator:v${VERSION} ${IMAGE_REPO}/postgres-operator:v${VERSION}
docker tag postgres-instance:v${VERSION} ${IMAGE_REPO}/postgres-instance:v${VERSION}

docker push ${IMAGE_REPO}/postgres-instance:v${VERSION}
docker push ${IMAGE_REPO}/postgres-operator:v${VERSION}

kapp deploy -a postgres-operator -y \
-f <(kubectl create secret docker-registry postgres-harbor \
--docker-server="${HARBOR_DOMAIN}" \
--docker-username="${HARBOR_USERNAME}" \
--docker-password="${HARBOR_PASSWORD}" \
--dry-run=client \
-o yaml)

helm upgrade --install postgres-operator ./operator \
--atomic \
--set operatorImageRepository="${IMAGE_REPO}/postgres-operator" \
--set postgresImageRepository="${IMAGE_REPO}/postgres-instance" \
--set dockerRegistrySecretName="postgres-harbor"

