
#!/usr/bin/env bash

GFSH_VERSION="9.10.6"
CHART_NAME="gemfire-operator"
NAMESPACE="gemfire-system"
TANZU_GEMFIRE_INSTALLATION_NAME="${CHART_NAME}"
cd /tmp/tanzu-gemfire-install/${TANZU_GEMFIRE_INSTALLATION_NAME} || exit
helm uninstall "${CHART_NAME}" --timeout="1m"
kapp delete -a ${CHART_NAME} -y
kubectl delete namespace ${NAMESPACE}
rm -Rf /tmp/gemfire-operator.tgz /tmp/tanzu-gemfire-install /tmp/pivotal-gemfire-${GFSH_VERSION} /tmp/pivotal-gemfire-${GFSH_VERSION}.tgz
sudo rm -Rf /usr/local/bin/gfsh
