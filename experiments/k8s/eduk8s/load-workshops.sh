#!/bin/bash

# Load workshop definitions and create workshop training portals

## Container Basics
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-container-basics/master/resources/workshop.yaml
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-container-basics/master/resources/training-portal.yaml

## Kubernetes Fundamentals
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-k8s-fundamentals/master/resources/workshop.yaml
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-k8s-fundamentals/master/resources/training-portal.yaml

## Getting Started with Carvel
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-getting-started-with-carvel/master/resources/workshop.yaml
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-getting-started-with-carvel/master/resources/training-portal.yaml

## Getting Started with Spring Boot Kubernetes 
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-spring-boot-k8s-getting-started/master/resources/workshop.yaml
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-spring-boot-k8s-getting-started/master/resources/training-portal.yaml

## Spring Boot Kubernetes Probes
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-spring-boot-k8s-probes/master/resources/workshop.yaml
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-spring-boot-k8s-probes/master/resources/training-portal.yaml
 
## Getting Started with Octant
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-getting-started-with-octant/master/resources/workshop.yaml
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-getting-started-with-octant/master/resources/training-portal.yaml

## Image Security
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-image-security/master/resources/workshop.yaml
kubectl apply -f https://raw.githubusercontent.com/eduk8s-labs/lab-image-security/master/resources/training-portal.yaml

# Verify resources were created
kubectl get eduk8s-training -o name

# List the workshop instances that were created
kubectl get workshopsessions
