
#!/usr/bin/env bash

VERSION="v1.0.0-alpha.1"
CHART_NAME="tanzu-configuration-service"
DEFAULT_NAMESPACE="${CHART_NAME}"
CONFIGURATION_SERVICE_INSTALLATION_NAME="tanzu-configuration-service-${VERSION}"
cd /tmp/tcs-install/${CONFIGURATION_SERVICE_INSTALLATION_NAME}/helm/${CHART_NAME} || exit
helm uninstall "${CHART_NAME}" -n "${DEFAULT_NAMESPACE}" --timeout="1m"
helm uninstall "${CHART_NAME}-crds" -n "${DEFAULT_NAMESPACE}" --timeout="1m"
kubectl delete ns ${DEFAULT_NAMESPACE}
rm -Rf /tmp/tcs-install
