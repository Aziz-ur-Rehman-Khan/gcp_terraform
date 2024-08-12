output "repository_url" {
  description = "The URL of the Docker repository in Artifact Registry. This URL is constructed using the specified region, project ID, and the name of the Artifact Registry repository, and it is used to push or pull Docker images."
  value       = "${var.region}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.default.name}"
}
