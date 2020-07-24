#!/bin/bash

echo "Starting microk8s..."

microk8s start

microk8s kubectl get nodes -o wide
