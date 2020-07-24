#!/bin/bash

echo "Configuring microk8s..."

microk8s enable dns ingress rbac metrics-server prometheus storage
