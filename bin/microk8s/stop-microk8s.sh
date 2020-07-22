#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: stop-microk8s.sh {nodes}"
	exit 1
fi

NODES="$1"

echo "Shutting down microk8s on each node..."

for ((i=1;i<=$NODES;i++));
do
  echo "-- worker $i"
  multipass exec kube-node-$i -- sudo /snap/bin/microk8s.stop
done

echo "-- master"
multipass exec kube-master -- sudo /snap/bin/microk8s.stop

echo "Next step..."
echo "-- at a time that's convenient, you may wish to execute [ startup-microk8s.sh $NODES ]"
