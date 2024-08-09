resource "random_string" "random_suffix" {
  length  = 4
  special = false
  upper   = false
  lower   = true
  numeric  = true

  override_special = "_-"
}
# Create a static IP address
resource "google_compute_global_address" "static_ip" {
  name    = "${var.prefix}-${random_string.random_suffix.result}-lb-ip"
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

# Create a HTTP URL map
resource "google_compute_url_map" "http" {
  name            = "${var.prefix}-http"
  default_url_redirect {
    https_redirect = true
    strip_query = false
  }
}
# # Create a target HTTP proxy
resource "google_compute_target_http_proxy" "http" {
  name    = "${var.prefix}-http-proxy"
  url_map = google_compute_url_map.http.self_link
}

# Create a global forwarding rule
resource "google_compute_global_forwarding_rule" "http" {
  project = var.project
  name                  = "${var.prefix}-forwarding-rule"
  target                = google_compute_target_http_proxy.http.self_link
  port_range            = "80"
  ip_address            = google_compute_global_address.static_ip.self_link
  load_balancing_scheme = "EXTERNAL"
   depends_on = [google_compute_global_address.static_ip]
}

# Create a HTTPS URL map
resource "google_compute_url_map" "https" {
  name            = "${var.prefix}-https"
  default_service = google_compute_backend_service.cloud_run_backend.self_link
}
# Create a target HTTPS proxy
resource "google_compute_target_https_proxy" "https" {
  project = var.project

  name    = "${var.prefix}-https-proxy"
  url_map = google_compute_url_map.https.self_link
 ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}
# Create a global forwarding rule
resource "google_compute_global_forwarding_rule" "https" {
  project    = var.project
  name       = "${var.prefix}-https-rule"
  target     = google_compute_target_https_proxy.https.self_link
  ip_address = google_compute_global_address.static_ip.self_link
  port_range = "443"
   depends_on = [google_compute_global_address.static_ip]
}
resource "google_compute_managed_ssl_certificate" "default" {
  name    = "${var.prefix}-managed-ssl-cert"
  managed {
    domains = [var.domain_name]
  }
  project = var.project

}