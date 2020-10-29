# Terraform for installing Sealed Secrets for K8s

Problem: "I can manage all my K8s config in git, except Secrets."

Solution: Encrypt your Secret into a SealedSecret, which is safe to store - even to a public repository. The SealedSecret can be decrypted only by the controller running in the target cluster and nobody else (not even the original author) is able to obtain the original Secret from the SealedSecret.

Uses k14s [kapp](https://github.com/k14s/terraform-provider-k14s/blob/master/docs/k14s_kapp.md) Terraform provider to install [sealed secrets](https://github.com/bitnami-labs/sealed-secrets).

Starts with the assumption that you have already provisioned a cluster.

## Install CLI

```
./install-cli-{os}.sh
```
> Replace `{os}` with either: `macos` or `linux`

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `kubeconfig_path`

## Install Controller

```
./create-sealed-secrets.sh
```

## Use

See usage instructions [here](https://github.com/bitnami-labs/sealed-secrets#usage).
> You'll need to have installed the CLI

For a simple test try executing

```
kubectl create secret generic mysecret --dry-run=client --from-literal=foo=bar -o json | kubeseal > mysecret.json
```

## Remove

```
./destroy-sealed-secrets.sh
```
