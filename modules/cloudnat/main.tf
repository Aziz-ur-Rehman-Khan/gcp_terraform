resource "google_compute_router" "default" {
  name    = "${var.prefix}-router"
  region  = var.region
  network = var.network
  project = var.project
}

resource "google_compute_router_nat" "default" {
  name                               = "${var.prefix}-nat"
  router                             = google_compute_router.default.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}