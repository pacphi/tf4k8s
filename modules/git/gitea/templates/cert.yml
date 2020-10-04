apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: gitea-cert
  namespace: ${namespace}
spec:
  dnsNames:
  - '${gitea_domain}'
  issuerRef:
    kind: ClusterIssuer
    name: letsencrypt-prod
  secretName: gitea-tls-secret