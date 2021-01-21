apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: venafi-issuer
  namespace: ${namespace}
spec:
  venafi:
    # Set this to the GUID of the Venafi policy zone you want to use
    zone: ${venafi_policy_zone_guid} 
    cloud:
      apiTokenSecretRef:
        name: cloud-secret
        key: apikey