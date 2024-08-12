output "repository_url" {
  description = "The URL of the Docker repository in Artifact Registry. This URL is used to push or pull Docker images from the specified repository."
  value       = module.artifact_registry.repository_url
}

output "database_connection_name" {
  description = "The connection name of the Cloud SQL instance. This name is used to establish connections to the Cloud SQL instance from other services or applications."
  value       = module.cloud_sql.sql_instance_connection_name
}

output "cloudsql_instance_name" {
  description = "The name of the Cloud SQL instance. This is the identifier for the SQL instance within the Google Cloud project and is used to reference it in operations."
  value       = module.cloud_sql.sql_instance_name
}

output "cloud_run_service_url" {
  description = "The URL of the Cloud Run service. This URL is used to access the deployed application or service running on Cloud Run."
  value       = module.cloud_run.service_url
}

output "redis_connection_string" {
  description = "The connection string for the Redis instance, including the host and port. This string is used to connect to the Redis service for data operations."
  value       = "${module.memcached_redis.redis_host}:${module.memcached_redis.redis_port}"
}

output "load_balancer_https_endpoint" {
  description = "The HTTPS endpoint URL for the load balancer. This URL is used to access services through the load balancer over a secure connection."
  value       = module.load_balancer.https_endpoint
}

output "backend_bucket_url" {
  description = "The URL of the backend bucket in Google Cloud Storage. This URL is used to access the contents of the storage bucket."
  value       = module.storage.bucket_url
}

output "backend_bucket_name" {
  description = "The name of the backend bucket in Google Cloud Storage. This name is used to reference the bucket for operations and configurations."
  value       = module.storage.bucket_name
}

output "network_id" {
  description = "The ID of the VPC network. This ID is used to reference the network within Google Cloud resources and configurations."
  value       = module.vpc.network_id
}

output "network_name" {
  description = "The name of the VPC network. This name is used to identify the network within Google Cloud and for network-related configurations."
  value       = module.vpc.network_name
}

output "cloudsql_postgres_public_ip" {
  description = "The public IP address of the Cloud SQL PostgreSQL instance. This IP address allows external access to the PostgreSQL database."
  value       = module.cloud_sql.public_ip_address
}

output "cloudsql_postgres_private_ip" {
  description = "The private IP address of the Cloud SQL PostgreSQL instance. This IP address is used for internal communication within the VPC."
  value       = module.cloud_sql.private_ip_address
}