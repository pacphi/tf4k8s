
#!/usr/bin/env bash

FILE="/tmp/postgres-for-kubernetes.tar.gz"
VERSION="1.1.0"
CHART_NAME="postgres-operator"
TANZU_POSTGRES_INSTALLATION_NAME="postgres-for-kubernetes-v${VERSION}"
cd /tmp/tanzu-postgres-install/${TANZU_POSTGRES_INSTALLATION_NAME}/operator || exit
helm uninstall "${CHART_NAME}" --timeout="1m"
kapp delete -a ${CHART_NAME} -y
rm -Rf /tmp/tanzu-postgres-install
rm -f ${FILE}
