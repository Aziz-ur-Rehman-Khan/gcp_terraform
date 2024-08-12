output "redis_host" {
  description = "The private IP address of the Redis instance, used for secure and internal access within the VPC"
  value       = google_redis_instance.memcached.host
}
output "redis_port" {
  description = "The Port of the instance."
  value       = google_redis_instance.memcached.port
}
output "redis_instance_name" {
  description = "The name of the Redis instance. This is used to identify the Redis instance within the Google Cloud project."
  value       = google_redis_instance.memcached.name
}
output "network_peering" {
  description = "The peering configuration for the VPC network. This includes settings for importing and exporting custom routes between the VPC network and the service."
  value       = google_service_networking_connection.private_vpc_connection.peering
}