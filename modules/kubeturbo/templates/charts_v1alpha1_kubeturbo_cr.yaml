apiVersion: charts.helm.k8s.io/v1
kind: Kubeturbo
metadata:
  name: kubeturbo-release
spec:
  # Default values copied from <project_dir>/helm-charts/kubeturbo/values.yaml
  
  # Default values for kubeturbo.
  # This is a YAML-formatted file.
  # Declare variables to be passed into your templates.

  targetConfig:
    targetName: ${k8s_cluster_name}

  # Turbo server version and address
  serverMeta:
    version: "${turbo_server_version}"
    turboServer: ${turbo_server_url}

  # Turbo server api user and password stored in a secret or optionally specified as username and password
  # The opsManagerUserName requires Turbo administrator role
  restAPIConfig:
    #turbonomicCredentialsSecretName: "turbonomic-credentials"
    opsManagerUserName: ${turbo_username}
    opsManagerPassword: ${turbo_password}

  # Uncomment out lines to configure HA Node to ESX policies by node role. Default is master
  # Add more roles using format "\"foo\"\,\"bar\""
  #HANodeConfig:
  #  nodeRoles: "\"master\""

  # Uncomment next lines to specify a repository and image tag
  #image:
  #  repository: registry.connect.redhat.com
  #  tag: 8.0.0

  # Uncomment out to allow execution in OCP environments
  #args:
  #  sccsupport: "*"

  # Uncomment out to specify kubeturbo container specifications when needed (quotas set on ns)
  #resources:
  #  limits:
  #    memory: 4Gi
  #    cpu: "2"
  #  requests:
  #    memory: 512Mi
  #    cpu: "1"
