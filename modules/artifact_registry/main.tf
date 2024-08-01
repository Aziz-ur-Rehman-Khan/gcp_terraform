resource "google_artifact_registry_repository" "repository" {
  repository_id = var.name
  format   = "DOCKER"
  location = var.location
  project  = var.project_id

  lifecycle {
    prevent_destroy = true
  }
}
