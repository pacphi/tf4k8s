#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: destroy-multipass-vms.sh {nodes}"
	exit 1
fi

NODES="$1"

echo "Destroying multipass VMs..."
read -p "Ctrl+C to exit or press any key to continue"

for ((i=1;i<=$NODES;i++));
do
  echo "-- worker $i"
  multipass delete kube-node-$i
done

echo "-- master"
multipass delete kube-master

multipass purge
multipass list
