resource "google_compute_address" "static_ip" {
  name         = "${var.prefix}-lb-ip"
  project      = var.project
  region       = var.region
  address_type = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "${var.prefix}-forwarding-rule"
  project    = var.project
  target     = google_compute_target_http_proxy.default.self_link
  ip_address = google_compute_address.static_ip.address
  port_range = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${var.prefix}-http-proxy"
  project = var.project
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_url_map" "default" {
  name            = "${var.prefix}-url-map"
  project         = var.project
  default_service = var.cloud_run_service_name
}