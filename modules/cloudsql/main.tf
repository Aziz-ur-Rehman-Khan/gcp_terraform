resource "google_sql_database_instance" "postgres" {
  name             = "${var.prefix}-postgres"
  project          = var.project
  region           = var.region
  database_version = "POSTGRES_13"

  settings {
    tier = var.tier
  }
}
