#!/bin/bash

NAMESPACE=eduk8s
TLS_SECRET=eduk8s-tls-secret

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Usage: create-eduk8s.sh {release-version} {domain}"
	exit 1
fi

RELEASE_VERSION="$1"
DOMAIN="$2"

# Create namespace
kubectl create namespace ${NAMESPACE}

# Replace place-holdered values in certificate YAML then install it (depends on cert-manager)
cp cert.template cert.yml 
sed -i "s/EDUK8S_DOMAIN/$DOMAIN/" cert.yml
sed -i "s/EDUK8S_SECRET/$TLS_SECRET/" cert.yml
kubectl apply -f cert.yml

# Deploy operator
kubectl apply -k "github.com/eduk8s/eduk8s?ref=${RELEASE_VERSION}"

# Specify the ingress class (depends on nginx-ingress-controller)
kubectl set env deployment/eduk8s-operator -n ${NAMESPACE} INGRESS_CLASS=nginx


# Specify ingress domain
kubectl set env deployment/eduk8s-operator -n ${NAMESPACE} INGRESS_DOMAIN=${DOMAIN}

# Enforce secure connections
kubectl set env deployment/eduk8s-operator -n ${NAMESPACE} INGRESS_SECRET=${TLS_SECRET}
