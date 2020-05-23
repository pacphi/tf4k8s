# Create a new service account on Google Cloud Platform

Authenticate

```
gcloud auth login
```

To create a new project, service account and credentials file

```
./create-iam.sh
```
> Works only if the account you are using has the IAM role `roles/resourcemanager/projectCreator` role assigned or has the `resourcemanager.projects.create` permission


To do the same, but in an existing project

```
./create-iam.sh <project-id>
```

To destroy the service account and credentials file

```
./destroy-iam.sh
```

To destroy the project you created (and all cloud resources within it)

```
./destroy-iam.sh <project-id>
```
> Use this variant with caution
