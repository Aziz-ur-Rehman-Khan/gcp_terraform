resource "google_sql_database_instance" "instance" {
  name             = var.name
  region           = var.region
  database_version = var.database_version
  deletion_protection = true

  settings {
    tier = var.tier

    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name = "public"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_user" "user" {
  name     = var.db_user
  instance = google_sql_database_instance.instance.name
  password = random_password.db_password.result
}

resource "random_password" "db_password" {
  length  = 16
  special = false
}
