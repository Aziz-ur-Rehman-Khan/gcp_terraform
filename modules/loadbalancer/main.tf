# Create a static IP address
resource "google_compute_global_address" "static_ip" {
  name    = "${var.prefix}-lb-ip"
  project = var.project
}

# Create a region network endpoint group for Cloud Run
resource "google_compute_region_network_endpoint_group" "cloud_run_neg" {
  name                  = "${var.prefix}-cloudrun-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region

  cloud_run {
    service = var.cloud_run_service_name
  }
}

# Create a backend service for Cloud Run
resource "google_compute_backend_service" "cloud_run_backend" {
  name                  = "${var.prefix}-cloud-run-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_region_network_endpoint_group.cloud_run_neg.id
  }
}

# Create a URL map
resource "google_compute_url_map" "default" {
  name            = "${var.prefix}-url-map"
  default_service = google_compute_backend_service.cloud_run_backend.self_link
}

# Create a target HTTP proxy
resource "google_compute_target_http_proxy" "default" {
  name    = "${var.prefix}-http-proxy"
  url_map = google_compute_url_map.default.self_link
}

# Create a global forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "${var.prefix}-forwarding-rule"
  target                = google_compute_target_http_proxy.default.self_link
  port_range            = "80"
  ip_address            = google_compute_global_address.static_ip.self_link
  load_balancing_scheme = "EXTERNAL"
}