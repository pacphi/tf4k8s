apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: concourse-cert
  namespace: ${namespace}
spec:
  dnsNames:
  - '${concourse_domain}'
  issuerRef:
    kind: ClusterIssuer
    name: letsencrypt-prod
  secretName: concourse-web-tls