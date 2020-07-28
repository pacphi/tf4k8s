# Getting started with Vagrant and microk8s

## Prerequisites

* Install [vagrant](https://www.vagrantup.com/)
* Install [virtualbox](https://virtualbox.org)


## Installation

Vagrant will consistently provision a master and `n` worker nodes each with 2 vCPU, 8Gb RAM, and a 60GB persistent disk running the [Ubuntu 20.04 image](https://app.vagrantup.com/ubuntu/boxes/focal64).

All mentions of a script parameter named `{nodes}` signifies the number of worker nodes the script applies to.

### Step 1: Create Vagrant VMs and install microk8s

```
export NODE_COUNT={nodes}
vagrant up
```
> You'll be prompted for an IP address range to configure `metallb` addon

### Step 2: Join worker nodes to master

```
./join-worker-nodes.sh {nodes}
```

### Optional: Start, stop and destroy

Start

```
vagrant up
```

Stop

```
vagrant suspend
```

Destroy

```
vagrant destroy
vagrant global-status --prune
```

## Use

To obtain the cluster connection credentials you could

```
vagrant ssh mk8s-master -- /snap/bin/microk8s.config
```
> Replace the `server:` IP address with `172.42.42.100` if you intend to store/append the credentials in/to `~/.kube/config`

## Credits

* [Using Vagrant with Multi-Node MicroK8S to experiment with Kubernetes](https://gist.github.com/JonTheNiceGuy/6ea77cb3e04eed48c4038ca06de3d0ae)
* Alexander Hill's [k8s_ubuntu](https://bitbucket.org/exxsyseng/k8s_ubuntu/src/master/) Bitbucket repository

## Troubleshooting

* [Vagrant box startup timeout due to no serial port ](https://bugs.launchpad.net/cloud-images/+bug/1829625)
