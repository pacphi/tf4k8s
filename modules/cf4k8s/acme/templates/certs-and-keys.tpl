system_certificate:
  crt: |
    ${system_certificate_full_chain}
  key: |
    ${system_cert_key}
  ca: ""

workloads_certificate:
  crt: |
    ${workloads_certificate_full_chain}
  key: |
    ${workloads_cert_key}
  ca: ""