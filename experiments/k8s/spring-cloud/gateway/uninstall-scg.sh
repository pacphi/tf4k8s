
#!/usr/bin/env bash

FILE="/tmp/spring-cloud-gateway-k8s.tgz"
VERSION="1.0.0"
CHART_NAME="spring-cloud-gateway"
DEFAULT_NAMESPACE="${CHART_NAME}"
SPRING_CLOUD_GATEWAY_INSTALLATION_NAME="spring-cloud-gateway-k8s-${VERSION}"
cd /tmp/scg-install/${SPRING_CLOUD_GATEWAY_INSTALLATION_NAME}/helm || exit
helm uninstall "${CHART_NAME}" -n "${DEFAULT_NAMESPACE}" --timeout="1m"
kubectl delete ns ${DEFAULT_NAMESPACE}
rm -Rf /tmp/scg-install
rm -f ${FILE}
