output "host" {
 description = "The IP address of the instance."
 value = "${google_redis_instance.redis.host}"
}
output "port" {
 description = "The Port of the instance."
 value = "${google_redis_instance.redis.port}"
}