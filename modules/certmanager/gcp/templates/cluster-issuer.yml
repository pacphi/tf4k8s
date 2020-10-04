apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
  namespace: ${namespace}
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    # This will register an issuer with LetsEncrypt.  Replace
    # with your admin email address.
    email: ${acmeEmail}
    privateKeySecretRef:
      # Set privateKeySecretRef to any unused secret name.
      name: letsencrypt-prod
    solvers:
    - dns01:
        cloudDNS:
          # Set this to your GCP project-id
          project: ${project}
          # Set this to the secret that we publish our service account key
          # in the previous step.
          serviceAccountSecretRef:
            name: cert-manager
            key: credentials.json
      selector:
        dnsZones:
        - "${domain}"