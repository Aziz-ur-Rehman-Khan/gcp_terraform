resource "google_redis_instance" "memcached" {
  name           = "${var.prefix}-memcached"
  project        = var.project
  region         = var.region
  tier           = "STANDARD_HA"
  memory_size_gb = 1
}
