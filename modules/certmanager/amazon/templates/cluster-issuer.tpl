apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
  namespace: ${namespace}
spec:
  acme:
    email: ${acmeEmail}
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    # @see https://cert-manager.io/docs/configuration/acme/dns01/route53/
    # this solver handles challenges for ${domain}
    # and uses explicit credentials
    - selector:
        dnsZones:
          - "${domain}"
      dns01:
        route53:
          region: ${region}
          hostedZoneID: ${hostedZoneId}
          accessKeyID: ${accessKeyId}
          # The following is the secret we created in Kubernetes. Issuer will use this to present challenge to AWS Route53.
          secretAccessKeySecretRef:
            name: route53-credentials-secret
            key: secret-access-key
