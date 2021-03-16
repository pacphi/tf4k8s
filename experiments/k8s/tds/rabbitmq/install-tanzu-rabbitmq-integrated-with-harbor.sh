#!/usr/bin/env bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ]; then
	echo "Usage: install-tanzu-rabbitmq-integrated-with-harbor.sh {harbor-domain} {harbor-project} {harbor-username} {harbor-password}"
	exit 1
fi

TANZU_RABBITMQ_OPERATOR_VERSION="1.4.0"

HARBOR_DOMAIN="$1"
HARBOR_PROJECT="$2"
HARBOR_USERNAME="$3"
HARBOR_PASSWORD="$4"
IMAGE_REPO="${HARBOR_DOMAIN}/${HARBOR_PROJECT}/rabbitmq"

./auth-registry.sh ${HARBOR_DOMAIN} ${HARBOR_USERNAME} ${HARBOR_PASSWORD}

cd /tmp/tanzu-rabbitmq-install/release-artifacts || exit

docker load -i ./images/cluster-operator.tar
docker images "rabbitmq-*"
docker tag rabbitmqoperator/cluster-operator:${TANZU_RABBITMQ_OPERATOR_VERSION} ${IMAGE_REPO}/cluster-operator:${TANZU_RABBITMQ_OPERATOR_VERSION}
docker push ${IMAGE_REPO}/cluster-operator:${TANZU_RABBITMQ_OPERATOR_VERSION}

cd manifests || exit

FIND="rabbitmqoperator/cluster-operator:${TANZU_RABBITMQ_OPERATOR_VERSION}"
REPLACE="${IMAGE_REPO}/cluster-operator:${TANZU_RABBITMQ_OPERATOR_VERSION}"

sed -i "s+${FIND}+${REPLACE}+g" cluster-operator.yml

kapp deploy -a rabbitmq-operator -y -f cluster-operator.yml

kubectl -n rabbitmq-system create secret \
docker-registry rabbitmq-cluster-registry-access \
--docker-server=${HARBOR_DOMAIN} \
--docker-username=${HARBOR_USERNAME} \
--docker-password=${HARBOR_PASSWORD}

kubectl -n rabbitmq-system patch serviceaccount \
rabbitmq-cluster-operator -p '{"imagePullSecrets": [{"name": "rabbitmq-cluster-registry-access"}]}'
