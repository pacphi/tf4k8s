#!/bin/bash

JENKINS_INSTANCE_NAME="${1:-prod-jenkins}"
JENKINS_NAMESPACE="${2:-jenkins}"

kubectl port-forward -n ${JENKINS_NAMESPACE} service/jenkins-operator-http-${JENKINS_INSTANCE_NAME} :8080
