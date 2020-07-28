# Getting started with multipass and microk8s

## Prerequisites

* Install [multipass](https://multipass.run/)


## Installation

All mentions of a script parameter named `{nodes}` signifies the number of worker nodes the script applies to.

### Step 1: Create multipass VMs

```
./create-multipass-vms.sh {vcpu} {mem} {disk} {nodes}
```

* `{vcpu}` is the number of virtual CPUs (e.g., 2)
* `{mem}` is an amount of memory (e.g., 2048M, 8G)
* `{disk}` is the reserved storage capacity (e.g., 50G)

### Step 2: Install microk8s

```
./install-microk8s.sh {nodes}
```

### Step 3: Join worker nodes to master

```
./join-worker-nodes.sh {nodes}
```

### Optional: Start, stop and destroy scripts

Start

```
./startup-multipass-vms.sh {nodes}
./startup-microk8s.sh
```

Stop

```
./stop-microk8s.sh
./stop-multipass-vms.sh {nodes}
```

Destroy

```
./destroy-multipass-vms.sh {nodes}
```

## Credits

* [How To Create And Launch Ubuntu VMs With Multipass On Linux](https://www.ostechnix.com/how-to-create-and-launch-ubuntu-vms-with-multipass-on-linux/)
* [Learning Kubernetes with MicroK8s and Multipass. Part-1](https://medium.com/@mohamedsinbox/learning-kubernetes-with-microk8s-and-multipass-part-1-5906fb7db9d3)


## Troubleshooting

[Multipass does not currently support bridge networking](https://github.com/canonical/multipass/issues/118), so the most expedient way to access a deployed service is through [kubectl port-forward](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/).

Other potential issues you may run across:

* [MultiPass does not start on Ubuntu server 18.04](https://forum.snapcraft.io/t/multipass-does-not-start-on-ubuntu-server-18-04/11365/10)
* [QEMU backend fails to realize dnsmasq died (and doesn't restart it)](https://github.com/canonical/multipass/issues/1475#)
* [Configure an alternative location for multipass VMs](https://github.com/canonical/multipass/issues/1215)
* [How to expose Microk8s containers, so they are available from another machine?](https://stackoverflow.com/questions/57530575/how-to-expose-microk8s-containers-so-they-are-available-from-another-machine)
* [Kubernetes Port Forwarding - Error listen tcp4 127.0.0.1:88: bind: permission denied](https://stackoverflow.com/questions/53775328/kubernetes-port-forwarding-error-listen-tcp4-127-0-0-188-bind-permission-de)