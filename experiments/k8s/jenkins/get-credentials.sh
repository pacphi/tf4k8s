#!/bin/bash

JENKINS_INSTANCE_NAME="${1:-prod-jenkins}"
JENKINS_NAMESPACE="${2:-jenkins}"

JENKINS_USERNAME=$(kubectl get secret jenkins-operator-credentials-${JENKINS_INSTANCE_NAME} -n ${JENKINS_NAMESPACE} -o 'jsonpath={.data.user}' | base64 -d)
JENKINS_PASSWORD=$(kubectl get secret jenkins-operator-credentials-${JENKINS_INSTANCE_NAME} -n ${JENKINS_NAMESPACE} -o 'jsonpath={.data.password}' | base64 -d)
echo "jenkins_username: ${JENKINS_USERNAME}"
echo "jenkins_password: ${JENKINS_PASSWORD}"
