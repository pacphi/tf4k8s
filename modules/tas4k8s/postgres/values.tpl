postgresqlPassword: ${postgres_password}
persistence:
  enabled: true
  existingClaim: postgres-pvc
volumePermissions:
  enabled: true
replication:
  enabled: false
initdbScripts:
  psql.sql: |
    CREATE DATABASE uaa;
    \c uaa;
    CREATE EXTENSION citext;
    CREATE DATABASE cloud_controller;
    \c cloud_controller;
    CREATE EXTENSION citext;
    CREATE DATABASE usage_service;
    \c usage_service;
    CREATE EXTENSION citext;
