apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: jcr-cert
  namespace: ${namespace}
spec:
  dnsNames:
  - '${jcr_domain}'
  issuerRef:
    kind: ClusterIssuer
    name: letsencrypt-prod
  secretName: jcr-tls-secret