variable "project" {
  description = "The GCP project ID where resources will be created."
  type        = string
}

variable "region" {
  description = "The GCP region where resources will be created. Default is 'me-central2'."
  type        = string
  default     = "me-central2"
}

variable "prefix" {
  description = "A prefix to be used for naming resources. This helps in identifying resources belonging to the same project or environment."
  type        = string
}
variable "cloud_run_service_name" {
  description = "The Cloud Run Service name that reqires Loadbalancer"
  type        = string
}