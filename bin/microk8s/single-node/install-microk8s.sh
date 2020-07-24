#!/bin/bash

echo "Installing microk8s..."

sudo snap install microk8s --classic
sudo usermod -a -G microk8s $USER
microk8s enable dns ingress rbac metrics-server prometheus storage

echo "Next step..."
echo "-- execute [ configure-microk8s.sh ]"