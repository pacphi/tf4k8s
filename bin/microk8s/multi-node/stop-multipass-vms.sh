#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: stop-multipass-vms.sh {nodes}"
	exit 1
fi

NODES="$1"

echo "Stopping multipass VMs..."

for ((i=1;i<=$NODES;i++));
do
  echo "-- worker $i"
  multipass stop kube-node-$i
done

echo "-- master"
multipass stop kube-master

echo "Next step..."
echo "-- at a time that's convenient, you may wish to restart multipass vms with [ startup-multipass-vms.sh $NODES ]"
