# Getting started with multipass and microk8s

## Prerequisites

* Install [multipass](https://multipass.run/)


## Installation

### Step 1: Create multipass VMs

```
./create-multipass-vms.sh {vcpu} {mem} {disk} {nodes}
```

### Step 2: Install microk8s

```
./install-microk8s.sh {nodes}
```

### Step 3: Start microk8s

```
./startup-microk8s.sh {nodes}
```

### Step 4: Configure microk8s

```
./configure-microk8s.sh {nodes}
```

### Step 5: Add worker nodes to master

For each worker node you should execute

```
multipass exec kube-master -- /snap/bin/microk8s.add-node
```

### Optional: Start and stop scripts

Start

```
./startup-multipass-vms.sh {nodes}
./startup-microk8s.sh {nodes}
```

Stop 

```
./stop-microk8s.sh {nodes}
./stop-multipass-vms.sh {nodes}
```

## Credits

* [How To Create And Launch Ubuntu VMs With Multipass On Linux](https://www.ostechnix.com/how-to-create-and-launch-ubuntu-vms-with-multipass-on-linux/)
* [Learning Kubernetes with MicroK8s and Multipass. Part-1](https://medium.com/@mohamedsinbox/learning-kubernetes-with-microk8s-and-multipass-part-1-5906fb7db9d3)


## Troubleshooting

* [MultiPass does not start on Ubuntu server 18.04](https://forum.snapcraft.io/t/multipass-does-not-start-on-ubuntu-server-18-04/11365/10)
* [QEMU backend fails to realize dnsmasq died (and doesn't restart it)](https://github.com/canonical/multipass/issues/1475#)