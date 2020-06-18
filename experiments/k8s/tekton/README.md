# Terraform for installing Tekton

Uses k14s [kapp](https://github.com/k14s/terraform-provider-k14s/blob/master/docs/k14s_kapp.md) Terraform provider to install [Tekton](https://github.com/tektoncd/pipeline/blob/master/docs/install.md#installing-tekton-pipelines-on-kubernetes).

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `kubeconfig_path`


## Install

```
./create-tekton.sh
```

### Configure a cloud storage bucket

You're strongly encouraged to [configure](https://github.com/tektoncd/pipeline/blob/master/docs/install.md#configuring-a-cloud-storage-bucket) a cloud storage bucket.

// TODO Attempt to integrate Minio which may provide some indirection with respect to managing storage

## Use

Access the dashboard with

```
kubectl -n tekton-pipelines port-forward svc/tekton-dashboard 9097:9097
```

then visit http://localhost:9097 in your favorite browser. (Use Ctrl+C to exit).

Peruse a couple tutorials to get your hands dirty, for example:

* Sora Liu's excellent [Tekton Pipeline Hello World Tutorial](https://blog.lovesora.pro/2019/11/21/pipeline/tekton/)
* [Tekton Pipelines Tutorial](https://github.com/tektoncd/pipeline/blob/master/docs/tutorial.md)

## Remove

```
./destroy-tekton.sh
```
