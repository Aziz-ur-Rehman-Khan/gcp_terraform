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

variable "container_image" {
  description = "The container image to deploy in Cloud Run. This should be a fully qualified image URL, such as 'gcr.io/my-project/my-image:tag'."
  type        = string
}
variable "env_files" {
  description = "Map of environment file paths for different environments"
  type        = string
}
variable "cloudsql_connection_name" {
  description = "Connection String for CloudSQL"
  type        = string
}

variable "redis_uri" {
  description = "The Redis URI"
  type        = string
}
variable "vpc_connector_id" {

}