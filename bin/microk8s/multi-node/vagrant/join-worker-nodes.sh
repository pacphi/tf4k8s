#!/bin/bash

shopt -s extglob

if [ -z "$1" ]; then
	echo "Usage: join-worker-nodes.sh {nodes}"
	exit 1
fi

NODES="$1"

echo "Joining worker nodes to mk8s-master..."

for ((i=1;i<=$NODES;i++));
do
  echo "-- worker $i"
  ADD_NODE=$(vagrant ssh mk8s-master -- /snap/bin/microk8s.add-node) && printf "$ADD_NODE" > add.tmp && CMD=$(sed -n '5p' add.tmp) && rm -f add.tmp
  echo $CMD
  vagrant ssh mk8s-worker-$i -- /snap/bin/${CMD##*( )}
done

