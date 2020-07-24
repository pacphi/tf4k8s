#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: startup-multipass-vms.sh {nodes}"
	exit 1
fi

NODES="$1"

echo "Starting multipass VMs..."

for ((i=1;i<=$NODES;i++));
do
  echo "-- worker $i"
  multipass start kube-node-$i
done

echo "-- master"
multipass start kube-master

echo "Next step..."
echo "-- at a time that's convenient, you may wish to execute [ startup-microk8s-vms.sh $NODES ]"
