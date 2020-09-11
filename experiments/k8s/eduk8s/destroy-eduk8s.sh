#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: destroy-eduk8s.sh {release-version}"
	exit 1
fi

RELEASE_VERSION="$1"

# Delete all current workshop environments
kubectl delete workshops,trainingportals,workshoprequests,workshopsessions,workshopenvironments --all

# Make sure everything got deleted
kubectl get workshops,trainingportals,workshoprequests,workshopsessions,workshopenvironments --all-namespaces

# Destroy the eduk8s operator
kubectl delete -k "github.com/eduk8s/eduk8s?ref=${RELEASE_VERSION}"

# Delete certificate and training-portal resources
rm cert.yml training-portal.yml
