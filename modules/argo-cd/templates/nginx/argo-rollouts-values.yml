installCRDs: true

clusterInstall: true

controller:
  name: argo-rollouts
  component: rollouts-controller
  image:
    repository: argoproj/argo-rollouts
    tag: ${argo_rollouts_version}

# Secrets with credentials to pull images from a private registry
imagePullSecrets: []
# - name: argo-pull-secret
