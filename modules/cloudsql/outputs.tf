output "sql_instance_name" {
  description = "The name of the Cloud SQL instance. This is used to identify the SQL instance within the Google Cloud project."
  value       = google_sql_database_instance.postgres.name
}

output "sql_instance_connection_name" {
  description = "The connection name of the Cloud SQL instance. This is a unique identifier used to connect to the instance from other services or applications."
  value       = google_sql_database_instance.postgres.connection_name
}

output "public_ip_address" {
  description = "The public IP address assigned to the Cloud SQL instance. This address allows external access to the database instance over the internet."
  value       = google_sql_database_instance.postgres.public_ip_address
}

output "private_ip_address" {
  description = "The private IP address assigned to the Cloud SQL instance. This address is used for internal communication within the VPC (Virtual Private Cloud)."
  value       = google_sql_database_instance.postgres.private_ip_address
}
output "postgres_connection_string" {
  description = "The connection string for the PostgreSQL database. This string can be used to connect to the database instance."
  value       = "postgres://${var.db_user_name}:${var.db_password}@${google_sql_database_instance.postgres.private_ip_address}:${var.db_port}/${var.db_name}"
}
