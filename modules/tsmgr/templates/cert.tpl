apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: tsmgr-cert
  namespace: ${namespace}
spec:
  dnsNames:
  - '${tsmgr_domain}'
  - '${broker_domain}'
  - '${daemon_domain}'
  issuerRef:
    kind: ClusterIssuer
    name: letsencrypt-prod
  secretName: tsmgr-tls-secret