# Create a VPC network
resource "google_compute_network" "peering_network" {
  name = "${var.prefix}-postgres-peering-network"
}

# Create an IP address
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "${var.prefix}-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.peering_network.id
}

# Create a private connection
resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.peering_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

# (Optional) Import or export custom routes
resource "google_compute_network_peering_routes_config" "peering_routes" {
  peering = google_service_networking_connection.default.peering
  network = google_compute_network.peering_network.name

  import_custom_routes = true
  export_custom_routes = true
}
resource "google_sql_database_instance" "postgres" {
  provider = google-beta

  name                = "${var.prefix}-postgres"
  project             = var.project
  region              = var.region
  deletion_protection = true
  database_version    = var.database_version
  depends_on          = [google_service_networking_connection.default]

  settings {
    maintenance_window {
      day  = 6
      hour = 2
    }
    tier              = var.tier
    availability_type = "REGIONAL"
    ip_configuration {
      ipv4_enabled                                  = true
      private_network                               = var.network
      enable_private_path_for_google_cloud_services = true

      authorized_networks {
        name  = "Allow-All"
        value = "0.0.0.0/0"
      }

    }

    backup_configuration {
      enabled                        = true
      binary_log_enabled             = true
      point_in_time_recovery_enabled = true
    }
  }
}
