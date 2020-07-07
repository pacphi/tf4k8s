output "db_password" {
  value = module.cloudsql_mysql.generated_user_password
}

output "db_instance_name" {
  value =  module.cloudsql_mysql.instance_name
}

output "db_instance_connection_name" {
  value = module.cloudsql_mysql.instance_connection_name
}

output "db_public_ip_address" {
  value = module.cloudsql_mysql.public_ip_address
}

output "db_instance_server_ca_cert" {
  value = module.cloudsql_mysql.instance_server_ca_cert
}

output "db_instance_service_account_email_address" {
  value = module.cloudsql_mysql.instance_service_account_email_address
}