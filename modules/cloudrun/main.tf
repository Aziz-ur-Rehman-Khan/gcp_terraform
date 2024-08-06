locals {
  # Read the content of the .env file for the specified environment
  env_content = file(var.env_files)

  # Parse the .env file content into a map of environment variables
  static_environment_variables = {
    for line in split("\n", local.env_content) :
    split("=", line)[0] => split("=", line)[1]
    if length(split("=", line)) == 2 &&
    substr(trimspace(line), 0, 1) != "#" &&
    trimspace(line) != ""
  }

  # Combine the parsed .env variables with other static variables
  environment_variables = merge(
    local.static_environment_variables,
    {
      "HOST"      = var.cloudsql_connection_name,
      "REDIS_URI" = var.redis_uri
      # Add other static variables as needed
    }
  )
}


resource "google_cloud_run_service" "default" {
  name     = "${var.prefix}-cloud-run-service"
  location = var.region
  project  = var.project

  template {
    spec {
      containers {
        image = var.container_image
        ports {
          container_port = 8080
        }

        dynamic "env" {
          for_each = local.environment_variables
          content {
            name  = env.key
            value = env.value
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}


resource "google_cloud_run_service_iam_member" "invoker" {
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
