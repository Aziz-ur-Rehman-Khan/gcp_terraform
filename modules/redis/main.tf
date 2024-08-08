// Enable Private Service Access
resource "google_project_service" "servicenetworking" {
  project = var.project
  service = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.prefix}-redis-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

  depends_on = [google_project_service.servicenetworking]
}

resource "google_compute_network_peering_routes_config" "peering_routes" {
  peering = google_service_networking_connection.private_vpc_connection.peering
  network = var.network

  import_custom_routes = true
  export_custom_routes = true
}

// Existing Redis instance resource
resource "google_redis_instance" "memcached" {
  name           = "${var.prefix}-redis"
  project        = var.project
  region         = var.region
  tier           = "BASIC"
  memory_size_gb = 1
  connect_mode   = "PRIVATE_SERVICE_ACCESS"
  authorized_network = var.network_id

  depends_on = [google_service_networking_connection.private_vpc_connection]
}