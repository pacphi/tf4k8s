replicaCount: 1

image:
  repository: avinetworks/ako
  pullPolicy: IfNotPresent

### This section outlines the generic AKO settings
AKOSettings:
  # enum: INFO|DEBUG|WARN|ERROR
  logLevel: "INFO"
  # This frequency controls how often AKO polls the Avi controller to update itself with cloud configurations.
  fullSyncFrequency: "1800"
  # Internal port for AKO's API server for the liveness probe of the AKO pod default=8080
  apiServerPort: 8080
  # Has to be set to true in configmap if user wants to delete AKO created objects from AVI 
  deleteConfig: "true"
  # If the POD networks are reachable from the Avi SE, set this knob to true.
  disableStaticRouteSync: "false"
  # A unique identifier for the kubernetes cluster, that helps distinguish the objects for this cluster in the avi controller. // MUST-EDIT
  clusterName: "${avi_cluster_name}"
  # Set the string if your CNI is calico or openshift. enum: calico|canal|flannel|openshift
  cniPlugin: "${avi_cni_plugin}" 
  #NamespaceSelector contains label key and value used for namespacemigration
  #Same label has to be present on namespace/s which needs migration/sync to AKO
  namespaceSelector:
    labelKey: ""
    labelValue: ""

### This section outlines the network settings for virtualservices. 
NetworkSettings:
  ## This list of network and cidrs are used in pool placement network for vcenter cloud.
  ## Node Network details are not needed when in nodeport mode / static routes are disabled / non vcenter clouds.
  nodeNetworkList: []
  # nodeNetworkList:
  #   - networkName: "network-name"
  #     cidrs:
  #       - 10.0.0.1/24
  #       - 11.0.0.1/24
  subnetIP: "" # Subnet IP of the vip network
  subnetPrefix: "" # Subnet Prefix of the vip network
  networkName: "" # Network Name of the vip network
  enableRHI: false # This is a cluster wide setting for BGP peering.

### This section outlines all the knobs  used to control Layer 7 loadbalancing settings in AKO.
L7Settings:
  defaultIngController: "true"
  l7ShardingScheme: "hostname"
  # enum NodePort|ClusterIP
  serviceType: ClusterIP
  # Use this to control the layer 7 VS numbers. This applies to both secure/insecure VSes but does not apply for passthrough. ENUMs: LARGE, MEDIUM, SMALL
  shardVSSize: "LARGE"
  # Control the passthrough virtualservice numbers using this ENUM. ENUMs: LARGE, MEDIUM, SMALL
  passthroughShardSize: "SMALL"

### This section outlines all the knobs  used to control Layer 4 loadbalancing settings in AKO.
L4Settings:
  # Use this knob to control the settings for the services API usage. Default to not using services APIs: https://github.com/kubernetes-sigs/service-apis
  advancedL4: "false"
  # If multiple sub-domains are configured in the cloud, use this knob to set the default sub-domain to use for L4 VSes.
  defaultDomain: ""

### This section outlines settings on the Avi controller that affects AKO's functionality.
ControllerSettings:
  # Name of the ServiceEngine Group.
  serviceEngineGroupName: "Default-Group"
  # The controller API version
  controllerVersion: "18.2.10"
  # The configured cloud name on the Avi controller.
  cloudName: "Default-Cloud"
  # IP address or Hostname of Avi Controller
  controllerHost: "${avi_hostname}"
  # If set to true, AKO will map each Kubernetes cluster uniquely to a tenant in Avi
  tenantsPerCluster: "false"
  # Name of the tenant where all the AKO objects will be created in AVI. // Required only if tenantsPerCluster is set to True
  tenantName: "admin"

resources:
  limits:
    cpu: 250m
    memory: 300Mi
  requests:
    cpu: 100m
    memory: 200Mi

rbac:
  # Creates the pod security policy if set to true
  pspEnable: false


avicredentials:
  username: ${avi_controller_username}
  password: ${avi_controller_password}
  # optional - used for controller identity verification
  #certificateAuthorityData: 

service:
  type: ClusterIP
  port: 80

persistentVolumeClaim: ""
mountPath: "/log"
logFile: "avi.log"
