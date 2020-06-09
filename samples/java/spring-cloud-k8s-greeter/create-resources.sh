#!/bin/bash

# Create namespace and configmap for this application to consume

kubectl create namespace bitter-tears
kubectl create configmap greetings-config --from-file=greetings-config.yml -n bitter-tears
kubectl apply -f namespace-reader.yml
