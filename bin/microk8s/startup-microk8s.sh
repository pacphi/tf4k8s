#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: startup-microk8s.sh {nodes}"
	exit 1
fi

NODES="$1"

echo "Starting microk8s on each node..."

echo "-- master"
multipass exec kube-master -- sudo /snap/bin/microk8s.start

for ((i=1;i<=$NODES;i++));
do
  echo "-- worker $i"
  multipass exec kube-node-$i -- sudo /snap/bin/microk8s.start
done

echo "Next step..."
echo "-- execute [ configure-microk8s.sh $NODES ]"
