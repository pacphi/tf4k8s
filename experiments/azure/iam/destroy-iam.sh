#!/bin/bash

set -e

if [ -z "$1" ]; then
	echo "Usage: destroy-iam.sh {environment-name}"
	exit 1
fi

ENVIRONMENT_NAME="$1"
az ad sp delete --id "http://aks-service-principal-for-${ENVIRONMENT_NAME}"
