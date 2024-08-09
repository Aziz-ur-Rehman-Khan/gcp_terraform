provider "google" {
  credentials = file("/home/dev/.config/gcloud/application_default_credentials.json")
  project     = "kilow-431017"
  region      = "me-central2"
  zone        = "me-central2-c"

}
terraform {
  backend "gcs" {
    bucket = "kilow-production-tf-state"
    prefix = "terraform/state"
  }
}
