#!/bin/bash

# Delete namespace-reader role and role-binding, and namespace and all resources within it

kubectl delete -f namespace-reader.yml
kubectl delete namespace bitter-tears