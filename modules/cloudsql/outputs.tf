output "sql_instance_name" {
  description = "The name of the Cloud SQL instance"
  value       = google_sql_database_instance.instance.name
}

output "sql_instance_connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.instance.connection_name
}

output "db_user" {
  description = "The database user"
  value       = var.db_user
}

output "db_password" {
  description = "The password for the database user"
  value       = random_password.db_password.result
  sensitive   = true
}
