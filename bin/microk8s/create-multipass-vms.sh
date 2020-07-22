#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4 "]; then
	echo "Usage: create-multipass-vms.sh {vcpu} {mem} {disk} {nodes}"
	exit 1
fi

VCPU="$1"
MEM="$2"
DISK="$3"
NODES="$4"

echo "Creating a cluster of $NODES nodes..."

echo "-- master"
multipass launch --name kube-master --cpus $VCPU --mem $MEM --disk $DISK

for ((i=1;i<=$NODES;i++));
do
  echo "-- worker $i"
  multipass launch --name kube-node-$i --cpus $VCPU --mem $MEM --disk $DISK  
done

multipass list

echo "Next step..."
echo "-- execute [ install-microk8s.sh {nodes} ]"