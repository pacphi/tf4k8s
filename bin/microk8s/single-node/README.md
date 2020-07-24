# Getting started with microk8s

## Installation

```
./install-microk8s.sh
```

Logout and login

```
./configure-microk8s.sh
```

### Optional: Start and stop scripts

Start

```
./startup-microk8s.sh
```

Stop

```
./stop-microk8s.sh
```

## Observations

I took these scripts for a spin on a Google Compute Engine VM.

In order to give myself some headroom for launching additional Kubernetes workloads I opted for running an Ubuntu 20.04 image on a preemptible [e2-standard-16](https://cloud.google.com/compute/all-pricing#e2_standard_machine_types) instance (16 vCPUs, 64 GB memory) with additional persistent storage of 200Gb at a cost of ~$0.16/hr.

After executing the install and configure scripts, I executed the [bom/setup-linux.sh](../../../bom/setup-linux.sh) script to install the remaining complement of software for working with `tf4k8s` experiments and modules.

Typical preparation after establishing a k8s dial-tone is to install: [cert-manager](../../../experiments/gcp/certmanager), [nginx-ingress-controller](../../../experiments/k8s/nginx-ingress), and [external-dns](../../../experiments/gcp/external-dns).  When you execute the configure microk8s script it enables the ingress add-on among others, therefore you don't need to install the nginx-ingress-controller.

Microk8s ingress has an outstanding [issue](https://github.com/ubuntu/microk8s/issues/824) which makes it incompatible with external-dns.  I first observed this issue having installed cert-manager, external-dns and then harbor. When I visited Cloud DNS I noticed an `A` alias record with an IP address of `127.0.0.1` rather than the public IP address of the VM hosting microk8s.

So what did I do?

I uninstalled external-dns, manually updated the `A` alias record in Cloud DNS to be the public IP address of the VM, then after waiting a few moments for the update to propagate, I was able to visit the Harbor fully-qualified domain in my browser.
