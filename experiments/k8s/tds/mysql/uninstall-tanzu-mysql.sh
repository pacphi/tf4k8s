
#!/usr/bin/env bash

VERSION="1.1.0"
TANZU_MYSQL_INSTALLATION_NAME="tanzu-mysql-for-kubernetes"
NAMESPACE="${TANZU_MYSQL_INSTALLATION_NAME}-system"
CHART_NAME="mysql-operator"
helm uninstall "${CHART_NAME}" --namespace ${NAMESPACE} --timeout="1m"
kapp delete -a ${CHART_NAME} -y
kubectl delete namespace ${NAMESPACE}
rm -Rf /tmp/tanzu-mysql-install
