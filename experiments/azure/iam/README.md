# Create a new service principal on Microsoft Azure

## Authenticate

```
az login
```

## List subscriptions

```
az account list
```
> One or more subscriptions may appear. Take note of an id, e.g., `"id": "43b2e2c4-5eaf-46fd-b133-f44a21402d99"`.

## Set your subscription id

```
az account set --subscription=<subsciption-id>
```
> Replace `<subscription-id>` with an active subscription id


## Create a new service principal

```
./create-iam.sh <subscription-id> <environment-name> <service-principal-password>
```

## Destroy the service principal

```
./destroy-iam.sh <environment-name>
```
