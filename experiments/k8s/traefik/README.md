# Terraform for creating a Traefik Proxy

This experiment wraps the [Traefik](https://github.com/traefik/traefik-helm-chart/tree/master/traefik) Helm chart.

Starts with the assumption that you have already provisioned a cluster.


## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `traefik_log_level`
* `kubeconfig_path`


## Create

```
./create-traefik.sh
```

### Setup port-forwarding

```
./port-forward.sh
```
> The script will forward requests from port 9000 on localhost to the same port in the pod/container. Remember to press Ctrl+c when you want to stop port-forwarding.

### Connect

Visit `http://localhost:9000/dashboard/` in your favorite browser to access the Traefik dashboard.
> If you get tripped up on attempting to visit the dashboard, see this [issue](https://github.com/traefik/traefik-helm-chart/issues/85#issuecomment-589436204)

## Destroy

To tear it down

```
./destroy-traefik.sh
```


## Additional Reading

* [Traefik & Kubernetes](https://doc.traefik.io/traefik/providers/kubernetes-crd/)
* [How to easily(ish!) get SSL/TLS configured for your web hosting needs using Traefik and cert-manager on Kubernetes](https://medium.com/@alexgued3s/how-to-easily-ish-471307f276a9)