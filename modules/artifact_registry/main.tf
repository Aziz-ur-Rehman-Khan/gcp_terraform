resource "google_artifact_registry_repository" "default" {
  location      = var.region
  project       = var.project
  repository_id = "${var.prefix}-repository"
  format        = "DOCKER"

  labels = {
    env = var.prefix
  }
}

resource "google_project_service" "artifact_registry" {
  service = "artifactregistry.googleapis.com"
  project = var.project
}
