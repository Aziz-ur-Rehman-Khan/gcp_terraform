resource "google_secret_manager_secret" "secret" {
  for_each  = var.secrets
  secret_id = each.key
  replication {
    auto {}
  }
  depends_on = [google_project_service.secretmanager_api]
}

resource "google_secret_manager_secret_version" "secret_data" {
  for_each    = var.secrets
  secret      = google_secret_manager_secret.secret[each.key].id
  secret_data = each.value
}

resource "google_secret_manager_secret_iam_member" "secret_access" {
  for_each  = var.secrets
  secret_id = google_secret_manager_secret.secret[each.key].id
  role      = "roles/secretmanager.secretAccessor"
  member    = format("serviceAccount:%s-compute@developer.gserviceaccount.com", data.google_project.project.number)
}

data "google_project" "project" {}

resource "google_project_service" "secretmanager_api" {
  service            = "secretmanager.googleapis.com"
  disable_on_destroy = false
}
