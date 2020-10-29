# Terraform for installing Kubeapps

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install [Kubeapps](https://github.com/kubeapps/kubeapps/blob/master/docs/user/getting-started.md).

Kubeapps is a web-based UI for deploying and managing applications in Kubernetes clusters.

Starts with the assumption that you have already provisioned a cluster.

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `ingress`
* `kubeconfig_path`

## Install

```
./create-kubeapps.sh
```

## Use

### Create a Kubernetes API token

For trying out Kubeapps, access to the Dashboard requires a Kubernetes API token to authenticate with the Kubernetes API server as shown below, but for any real installation of Kubeapps you should instead [configure an OAuth2/OIDC provider](https://github.com/kubeapps/kubeapps/blob/master/docs/user/using-an-OIDC-provider.md).

```bash
kubectl create serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator
```

> **NOTE** It's not recommended to create `cluster-admin` users for Kubeapps production usage. Please refer to the [Access Control](/docs/user/access-control.md) documentation to configure fine-grained access control for users.

To retrieve the token,

#### On Linux/macOS

```bash
kubectl get secret $(kubectl get serviceaccount kubeapps-operator -o jsonpath='{range .secrets[*]}{.name}{"\n"}{end}' | grep kubeapps-operator-token) -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}' && echo
```

#### On Windows

Create a file called `GetDashToken.cmd` with the following lines in it:

```bat
@ECHO OFF
REM Get the Service Account
kubectl get serviceaccount kubeapps-operator -o jsonpath={.secrets[].name} > s.txt
SET /p ks=<s.txt
DEL s.txt

REM Get the Base64 encoded token
kubectl get secret %ks% -o jsonpath={.data.token} > b64.txt

REM Decode The Token
DEL token.txt
certutil -decode b64.txt token.txt
```

Open a command prompt and run the `GetDashToken.cmd` Your token can be found in the `token.txt` file.

### Visit the Kubeapps dashboard

Visit `https://catalog.{domain}` in your favorite browser.  Use the API token you retrieved earlier in order to login.

## Remove

```
./destroy-kubeapps.sh
```
