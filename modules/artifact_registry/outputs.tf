output "repository_url" {
  value = "docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repository.name}"
}
