resource "google_vpc_access_connector" "default" {
  name          = "${var.prefix}-vpc-connector"
  project       = var.project
  region        = var.region
  network       = var.network
  ip_cidr_range = "10.8.0.0/28"
}

