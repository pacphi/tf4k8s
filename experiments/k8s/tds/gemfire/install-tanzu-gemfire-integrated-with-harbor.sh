#!/usr/bin/env bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ]; then
	echo "Usage: install-tanzu-gemfire-integrated-with-harbor.sh {harbor-domain} {harbor-project} {harbor-username} {harbor-password}"
	exit 1
fi

TANZU_GEMFIRE_INSTALLATION_NAME="tanzu-gemfire-for-kubernetes"
TANZU_GEMFIRE_VERSION="1.0.0"
GFSH_VERSION="9.10.6"

HARBOR_DOMAIN="$1"
HARBOR_PROJECT="$2"
HARBOR_USERNAME="$3"
HARBOR_PASSWORD="$4"
IMAGE_REPO="${HARBOR_DOMAIN}/${HARBOR_PROJECT}/gemfire"

./auth-registry.sh ${HARBOR_DOMAIN} ${HARBOR_USERNAME} ${HARBOR_PASSWORD}

docker tag registry.pivotal.io/${TANZU_GEMFIRE_INSTALLATION_NAME}/gemfire-controller:${TANZU_GEMFIRE_VERSION} ${IMAGE_REPO}/gemfire-controller:${TANZU_GEMFIRE_VERSION}
docker tag registry.pivotal.io/${TANZU_GEMFIRE_INSTALLATION_NAME}/gemfire-k8s:${TANZU_GEMFIRE_VERSION} ${IMAGE_REPO}/gemfire-k8s:${TANZU_GEMFIRE_VERSION}

docker push ${IMAGE_REPO}/gemfire-controller:${TANZU_GEMFIRE_VERSION}
docker push ${IMAGE_REPO}/gemfire-k8s:${TANZU_GEMFIRE_VERSION}

NAMESPACE="gemfire-system"
kubectl create namespace ${NAMESPACE}

kapp deploy -a gemfire-operator -y \
-f <(kubectl create secret docker-registry gemfire-harbor \
-n ${NAMESPACE} \
--docker-server="${HARBOR_DOMAIN}" \
--docker-username="${HARBOR_USERNAME}" \
--docker-password="${HARBOR_PASSWORD}" \
--dry-run=client \
-o yaml)

cd /tmp/tanzu-gemfire-install || exit

helm upgrade --install gemfire-operator \
--namespace ${NAMESPACE} \
--cleanup-on-fail \
./gemfire-operator \
--atomic \
--set controllerImage="${IMAGE_REPO}/gemfire-controller:${TANZU_GEMFIRE_VERSION}"

sudo cp "/tmp/pivotal-gemfire-${GFSH_VERSION}/bin/gfsh" /usr/local/bin
