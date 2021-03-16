
#!/usr/bin/env bash

CHART_NAME="rabbitmq-operator"
NAMESPACE="rabbitmq-system"
kapp delete -a ${CHART_NAME} -y
rm -Rf "/tmp/${CHART_NAME}.tar" "/tmp/tanzu-rabbitmq-install"
