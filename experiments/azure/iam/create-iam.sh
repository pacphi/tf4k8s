#!/bin/bash

set -e

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: create-iam.sh {subscription-id} {environment-name} {service-principal-password}"
	exit 1
fi

SUBSCRIPTION_ID="$1"
ENVIRONMENT_NAME="$2"
CLIENT_SECRET="$3"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}" --name "aks-service-principal-for-${ENVIRONMENT_NAME}"
# Frequently the Azure CLI command above auto-generates passwords for service principals that have special characters, and that can cause trouble... we're going to save headaches later by doing this...
az ad sp credential reset --name "aks-service-principal-for-${ENVIRONMENT_NAME}" --password "${CLIENT_SECRET}"

echo "Take careful note of these new service principal credentials! Verify you can login with them by executing [ az login --service-principal -u {appId} --tenant {tenant} ]. You will be prompted to enter the {password}."
echo "You will also want to generate a new private/public key pair. Execute [ ssh-keygen -t rsa -b 4096 -C {email-address} ].  Replace {email-address} with a valid email address.  When complete, note the fully-qualified path to the public key."