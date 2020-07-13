applications:
- name: console
  docker:
    image: ${docker_image}
  instances: 1
  memory: 128M
  disk_quota: 384M
  env:
    SESSION_STORE_SECRET: ${session_store_secret}
  services:
  - console_db