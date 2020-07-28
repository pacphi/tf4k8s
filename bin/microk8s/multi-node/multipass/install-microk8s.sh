#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: install-microk8s.sh {nodes}"
	exit 1
fi

NODES="$1"

echo "Installing microk8s on each node..."

echo "-- master"
multipass exec kube-master -- sudo snap install microk8s --classic
multipass exec kube-master -- sudo usermod -a -G microk8s ubuntu

for ((i=1;i<=$NODES;i++));
do
  echo "-- worker $i"
  multipass exec kube-node-$i -- sudo snap install microk8s --classic
  multipass exec kube-node-$i -- sudo usermod -a -G microk8s ubuntu
done

echo "Next step..."
echo "-- execute [ join-worker-nodes.sh $NODES ]"