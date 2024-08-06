output "redis_host" {
  description = "The IP address of the instance."
  value       = google_redis_instance.memcached.host
}
output "redis_port" {
  description = "The Port of the instance."
  value       = google_redis_instance.memcached.port
}