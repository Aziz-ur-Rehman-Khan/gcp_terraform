resource "google_cloud_run_service" "service" {
  name     = var.name
  location = var.location

  template {
    spec {
      containers {
        image = var.container_image
        env {
          name  = "REDIS_HOST"
          value = var.redis_host
        }
        env {
          name  = "REDIS_PORT"
          value = var.redis_port
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = var.max_scale
        "run.googleapis.com/cloudsql-instances" = var.cloudsql_instance_connection_name
        "run.googleapis.com/client-name"        = "terraform"
      }
    }
  }

  autogenerate_revision_name = true
}

resource "google_project_iam_member" "cloud_run_service_account" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_cloud_run_service.service.email}"
}

