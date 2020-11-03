kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: postgres-pvc
  namespace: ${postgres_instance_namespace}
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 25Gi