output "repository_url" {
  value = "${var.region}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.default.name}"
}
