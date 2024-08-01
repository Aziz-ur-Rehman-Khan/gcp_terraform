provider "google" {
credentials = file("<path-to-your-service-account-key>.json")
  project     = "voodoo-409609"
  region  = "us-central1"
  zone    = "us-central1-c"
}