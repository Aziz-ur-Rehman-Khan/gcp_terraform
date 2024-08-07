resource "google_compute_router" "router" {
  name    = "${var.prefix}-router"
  region  = var.region
  network = var.network

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_address" "address" {
  count  = 1
  name   = "${var.prefix}-nat-manual-ip-${count.index}"
  region = var.region
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_router_nat" "nat_manual" {
  name   = "${var.prefix}-router-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.address.*.self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = var.subnet_id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  lifecycle {
    prevent_destroy = true
  }
}