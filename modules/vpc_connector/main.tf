resource "google_vpc_access_connector" "default" {
  name          = "${var.prefix}-vpc-connector"
  project       = var.project
  region        = var.region
  network       = var.network
  ip_cidr_range = "10.8.0.0/28"
  min_instances = 2
  max_instances = 10
  subnet {
    name = google_compute_subnetwork.custom_test.name
  }
}

resource "google_compute_subnetwork" "custom_test" {
  name          = "vpc-con"
  ip_cidr_range = "10.2.0.0/28"
  region        = "us-central1"
  network       = "default"
}