#!/usr/bin/env bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: install-tcs-integrated-with-harbor.sh {harbor-domain} {harbor-project} {harbor-username}"
	exit 1
fi

VERSION="v1.0.0-alpha.1"
CONFIGURATION_SERVICE_INSTALLATION_NAME="tanzu-configuration-service-${VERSION}"
HARBOR_DOMAIN="$1"
HARBOR_PROJECT="$2"
IMAGE_REPO="${HARBOR_DOMAIN}/${HARBOR_PROJECT}/configuration-service"
HARBOR_USERNAME="$3"

cd /tmp/tcs-install/${CONFIGURATION_SERVICE_INSTALLATION_NAME} || exit

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_PATH="$SCRIPT_DIRECTORY/helm"
TCS_VALUES_FILE_PARENT_DIR="${BASE_PATH}/tanzu-configuration-service"
TCS_VALUES_FILENAME="tcs-install-values.yaml"

TCS_VALUES_FILE_CONTENT=$(cat <<EOF
imageCredentials:
  registry: "$IMAGE_REPO"
  username: "$HARBOR_USERNAME"
EOF
)

mv ${TCS_VALUES_FILE_PARENT_DIR}/${TCS_VALUES_FILENAME} ${TCS_VALUES_FILE_PARENT_DIR}/${TCS_VALUES_FILENAME}.backup
echo "${TCS_VALUES_FILE_CONTENT}" > ${TCS_VALUES_FILE_PARENT_DIR}/${TCS_VALUES_FILENAME}

./scripts/relocate-images.sh ${IMAGE_REPO}
./scripts/install-tanzu-configuration-service.sh
