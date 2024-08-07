resource "google_sql_database_instance" "postgres" {
  name             = "${var.prefix}-postgres"
  project          = var.project
  region           = var.region
  database_version = var.database_version
  settings {
    tier = var.tier
  }

  lifecycle {
    prevent_destroy = true
  }
}
