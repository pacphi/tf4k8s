#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Usage: load-workshops.sh {domain}"
	exit 1
fi

DOMAIN="$1"
TLS_SECRET=eduk8s-tls-secret

# Load workshop definitions

## Container Basics
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-container-basics/master/resources/workshop.yaml

## Kubernetes Fundamentals
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-k8s-fundamentals/master/resources/workshop.yaml

## Getting Started with Carvel
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-getting-started-with-carvel/master/resources/workshop.yaml

## Getting Started with Spring Boot Kubernetes 
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-spring-boot-k8s-getting-started/master/resources/workshop.yaml

## Spring Boot Kubernetes Probes
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-spring-boot-k8s-probes/master/resources/workshop.yaml
 
## Getting Started with Octant
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-getting-started-with-octant/master/resources/workshop.yaml

## Tanzu End-to-end 
kubectl apply -f https://raw.githubusercontent.com/tanzu-end-to-end/end-to-end-workshop/main/resources/workshop.yaml

## Setup training portal
cp training-portal.template training-portal.yml 
sed -i "s/EDUK8S_DOMAIN/$DOMAIN/" training-portal.yml
sed -i "s/EDUK8S_SECRET/$TLS_SECRET/" training-portal.yml
kubectl apply -f training-portal.yml

# Verify resources were created
kubectl get eduk8s-training -o name

# List the workshop instances that were created
kubectl get workshopsessions
