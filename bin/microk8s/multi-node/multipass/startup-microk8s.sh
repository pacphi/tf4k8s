#!/bin/bash

echo "Starting microk8s..."

multipass exec kube-master -- sudo /snap/bin/microk8s.start

multipass exec kube-master -- /snap/bin/microk8s.kubectl get nodes -o wide
