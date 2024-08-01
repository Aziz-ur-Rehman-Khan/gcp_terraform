variable "name" {
  description = "The name of the Artifact Registry repository."
  type        = string
}

variable "location" {
  description = "The location where the Artifact Registry repository will be created."
  type        = string
}

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}
