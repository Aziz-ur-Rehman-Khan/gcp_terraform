resource "google_storage_bucket" "main_bucket" {
  name     = "${var.prefix}-bucket"
  location = var.region

  uniform_bucket_level_access = true

}