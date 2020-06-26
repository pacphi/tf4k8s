# Bill of Materials

You'll need a minimal complement of software to provision IaaS and build, run, and work with Kubernetes clusters.

You may choose to install them ad hoc or use one of the OS-specific scripts to make it easier to get started.

## Menu

### Command-line Interfaces

#### for working with Cloud provider platforms

- [x] Alibaba Cloud ([aliyun](https://github.com/aliyun/aliyun-cli#installation))
- [x] Amazon Web Services ([aws](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) + [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html))
- [x] Microsoft Azure ([az](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest))
- [x] Digital Ocean ([doctl](https://www.digitalocean.com/docs/apis-clis/doctl/how-to/install/))
- [x] Google Cloud Platform ([gcloud](https://cloud.google.com/sdk/install))
- [x] Oracle Cloud ([oci](https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/climanualinst.htm))

#### for IaaS and managed-services provisioning

- [x] Cloud Foundry ([bosh](https://bosh.io/docs/cli-v2-install/))
- [x] Hashicorp ([terraform](https://learn.hashicorp.com/terraform/getting-started/install.html))

#### to download commercially licensed tools

- [x] [VMWare Tanzu Network](https://network.pivotal.io) client ([pivnet](https://github.com/pivotal-cf/pivnet-cli#installing))

### Cloud Foundry-centric

- [x] [cf](https://docs.cloudfoundry.org/cf-cli/install-go-cli.html)

### Kubernetes-centric

- [x] [argo-cd](https://github.com/argoproj/argo-cd/blob/master/docs/cli_installation.md)
- [x] [helm](https://helm.sh/docs/intro/install/)
- [x] [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [x] [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [x] [k14s](https://k14s.io)
  * including imgpkg, kapp, kbld, kwt, and vendir
- [x] [k14s Terraform provider](https://github.com/k14s/terraform-provider-k14s)
- [x] [k9s](https://k9scli.io/topics/install/)
- [x] [krew](https://krew.sigs.k8s.io/docs/user-guide/setup/install/)
- [x] [octant](https://octant.dev)
- [x] [tekton](https://github.com/tektoncd/cli)

### Other

- [x] [git](https://git-scm.com/downloads)
- [x] [gpg](https://gnupg.org/download/)
- [x] [graphviz](https://graphviz.gitlab.io/download/)
- [x] [libressl](https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/)
- [x] [openssl](https://www.openssl.org/source/)
- [x] [keybase](https://keybase.io/download)
- [x] [httpie](https://httpie.org/docs#installation)
- [x] [terraform-docs](https://github.com/segmentio/terraform-docs)
- [x] [tflint](https://github.com/terraform-linters/tflint)


## Scripts

For the impatient, everything listed in the [menu](#menu) above gets installed.

### MacOS

```
./setup-macos.sh
```

Employs [brew](https://brew.sh)

### Linux

```
./setup-linux.sh
```
> Ubuntu distros only

Employs [apt-get](https://help.ubuntu.com/community/AptGet/Howto) and [snap](https://snapcraft.io/docs/installing-snap-on-ubuntu)

### Windows

```
.\setup-windows.ps1
```

Employs [chocolatey](https://chocolatey.org) and [scoop](https://scoop.sh)
