resource "google_redis_instance" "memcached" {
  name           = "${var.prefix}-redis"
  project        = var.project
  region         = var.region
  tier           = "BASIC"
  memory_size_gb = 1
}
