#!/bin/bash

echo "Enabling microk8s addons on mk8s-master..."
sudo microk8s.enable dns ingress rbac metrics-server prometheus storage