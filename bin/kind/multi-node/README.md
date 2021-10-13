# Getting started with Kind

## Prerequisites

* Install docker-ce
  * [Linux](https://docs.docker.com/engine/install/ubuntu/)
  * [MacOS](https://docs.docker.com/docker-for-mac/install/)
* Install [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)


## Installation

Scripts provided are for convenience only.  Take a look at them, then adapt for your own purposes.

### Step 1: Create cluster

```
.bootstrap.sh
```
> Creates a five node cluster with one master and four worker nodes

### Step 2: Add ingress

```
./add-ingress.sh
```

### Step 3: Add load balancer

```
./add-metallb.sh
```

### Optional: Teardown

```
./teardown.sh
```

## Use

To obtain the cluster connection credentials you could

```
export KUBECONFIG=$(kind get kubeconfig-path --name=kind-demo)
```

## Observations

I took these scripts for a spin on an internet connected [System76 Meerkat](https://system76.com/desktops/meerkat) running [Ubuntu 20.04](https://releases.ubuntu.com/20.04/).

Conducting experiments amounted in the least amount of fuss.

Once the cluster was up-and-running I hooked up [Lens](https://github.com/lensapp/lens).  Then I configured and installed [iam](../../../experiments/gcp/iam), [dns](../../../experiments/gcp/dns), [external-dns](../../../experiments/gcp/external-dns), [harbor](../../../experiments/k8s/harbor), and [gitea](../../../experiments/k8s/gitea) experiments.  All completed in under 15 minutes... chef's kiss.

On a disappointing note though, kind clusters [do not yet install metrics-server](https://github.com/kubernetes-sigs/kind/issues/398) so you're flying blind with respect to cluster telemetry.


## Credits

* BogoToBogo's [Multi-node local Kubernetes cluster](https://www.bogotobogo.com/DevOps/Docker/Docker-Kubernetes-Multi-Node-Local-Clusters-kind.php)
