#!/bin/bash

shopt -s extglob

if [ -z "$1" ]; then
	echo "Usage: join-worker-nodes.sh {nodes}"
	exit 1
fi

NODES="$1"

echo "Joining worker nodes to master..."

for ((i=1;i<=$NODES;i++));
do
  echo "-- worker $i"
  ADD_NODE=$(multipass exec kube-master -- /snap/bin/microk8s.add-node) && printf "$ADD_NODE" > add.tmp && CMD=$(sed -n '4p' add.tmp) && rm -f add.tmp
  multipass exec kube-node-$i -- /snap/bin/${CMD##*( )}
done

multipass exec kube-master -- /snap/bin/microk8s.kubectl get nodes -o wide

echo "Next step..."
echo "-- optionally execute [ multipass exec kube-master -- /snap/bin/microk8s.config ] appending or replacing output to ~/.kube/config"
