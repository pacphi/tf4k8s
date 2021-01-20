# Terraform for creating a Jenkins CI/CD instance

This experiment wraps the [Jenkins Operator](https://github.com/jenkinsci/kubernetes-operator) for Kubernetes.

Starts with the assumption that you have already provisioned a cluster.


## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `jenkins_instance_name`
* `jenkins_namespace`
* `jenkins_k8s_operator_commit_hash`
  * Visit [jenkinsci/kubernetes-operator](https://github.com/jenkinsci/kubernetes-operator/tags) and consult commit hashes associated with tags if you want to update the default value
* `kubeconfig_path`


## Create

```
./create-jenkins.sh
```
> You can override the default `{jenkins_instance_name}` and `{jenkins_namespace}` by passing them as arguments to this script.

## Use

### Obtain credentials

```
./get-credentials.sh
```

### Setup port-forwarding

```
./port-forward.sh
```
> You can override the default `{jenkins_instance_name}` and `{jenkins_namespace}` by passing them as arguments to this script. The script will find a randomly available localhost `{port}` and forward requests to the service. Remember to press Ctrl+c when you want to stop port-forwarding.

### Connect

Visit `http://localhost:{port}` in your favorite browser to access the Jenkins UI and use the credentials you obtained earlier to login.


## Customization

Consult the Jenkins Operator [documentation](https://jenkinsci.github.io/kubernetes-operator/docs/getting-started/latest/configuration/) for how to configure seed jobs and pipelines.  If you wish to bootstrap your instance of Jenkins with one or more jobs, you will want to add `path_to_jenkins_instance_config` to your `terraform.tfvars` and supply a value.  Review the commented section in the sample [here](../../../modules/jenkins/templates/jenkins.yaml) to learn how to define `seedJobs`.


## Destroy

To tear it down

```
./destroy-jenkins.sh
```
