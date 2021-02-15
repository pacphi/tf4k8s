apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: stratos-cert
  namespace: ${namespace}
spec:
  dnsNames:
  - '${stratos_domain}'
  issuerRef:
    kind: ClusterIssuer
    name: letsencrypt-prod
  secretName: stratos-tls-secret