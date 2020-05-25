# Create a new service principal on Microsoft Azure

Authenticate

```
az login
```

Find out what subscriptions you have

```
az account list
```
> One or more subscriptions may appear e.g., `"id": "43b2e2c4-5eaf-46fd-b133-f44a21402d99"`

Set your subscription id

```
az account set --subscription=<subsciption-id>
```
> Replace `<subscription-id>` with an active subscription id


To create a service principal

```
./create-iam.sh <subscription-id> <environment-name> <service-principal-password>
```

To destroy the service principal

```
./destroy-iam.sh <environment-name>
```
