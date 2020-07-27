#!/bin/bash

echo "Installing microk8s..."

sudo snap install microk8s --classic
sudo usermod -a -G microk8s $USER

sudo microk8s enable dns ingress rbac metallb metrics-server prometheus storage
mkdir -p /home/$USER/.kube
sudo microk8s config > /home/$USER/.kube/config

echo "Please logout and log back in"
