apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: cf4k8s-cert
  namespace: ${namespace}
spec:
  dnsNames:
  - '*.${system_domain}'
  - '*.${app_domain}'
  issuerRef:
    kind: ClusterIssuer
    name: letsencrypt-prod
  secretName: cf4k8s-tls-secret
