resource "random_id" "suffix" {
  byte_length = 4
}

module "cloudsql_mysql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "7.1.0"
  
  database_version = var.database_version
  tier = var.database_tier
  user_name = var.database_username
  db_charset = "utf8"
  db_collation = "utf8_general_ci"
  encryption_key_name = var.encryption_key_name 
  name = "${var.name}-${random_id.suffix.hex}"
  project_id = var.project
  region = var.region
  zone = var.zone

  activation_policy = "ALWAYS"
  additional_databases = var.additional_databases
  additional_users = var.additional_users
  availability_type = "ZONAL"

  backup_configuration = {
    binary_log_enabled = false
    enabled = false
    start_time = "02:00"
  }

  ip_configuration = {
    ipv4_enabled = true
    private_network = null
    require_ssl = true
    authorized_networks = var.authorized_networks
  }

  create_timeout = "10m"
  update_timeout = "10m"
  delete_timeout = "10m"
  disk_autoresize = true
  disk_type = "PD_SSD"
  failover_replica = false
  maintenance_window_day = 6
  maintenance_window_hour = 2
  maintenance_window_update_track = "stable"
  pricing_plan = "PER_USE"
  user_host = "%"
}
