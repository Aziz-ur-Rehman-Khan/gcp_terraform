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
variable "database_version" {
  description = "The database version to use."
  type        = string
  default     = "POSTGRES_16"
}

variable "tier" {
  description = "The machine type for the Cloud SQL instance."
  type        = string
  default     = "db-g1-small"
}

variable "network" {
  description = "The name of the VPC network to use. Default is 'default'."
  type        = string
  default     = "default"
}
variable "network_id" {
  description = "The name of the VPC network Id to use. Default is 'default'."
  type        = string
  default     = "default"
}