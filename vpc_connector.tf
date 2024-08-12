resource "google_vpc_access_connector" "connector" {
  name          = "vpc-access-connector"
  ip_cidr_range = "10.58.167.0/28"
  network       = module.vpc.network_name
}