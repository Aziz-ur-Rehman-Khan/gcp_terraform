output "secrets" {
  value = {
    for key, secret in google_secret_manager_secret.secret : key => {
      id     = secret.id
      latest = google_secret_manager_secret_version.secret_data[key].id
    }
  }
}
