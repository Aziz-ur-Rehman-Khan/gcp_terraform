variable "project_id" {
  description = "The GCP project ID where resources will be created."
  type        = string
  default     = "kilow-431017"
}
variable "region" {
  description = "The GCP region where resources will be created. Default is 'me-central2'."
  type        = string
  default     = "me-central2"
}
variable "project_prefix" {
  description = "A prefix to be used for naming resources. This helps in identifying resources belonging to the same project or environment."
  type        = string
  default     = "kilow"
}