variable "name" {
  description = "The name of the Cloud SQL instance."
  type        = string
}

variable "region" {
  description = "The region where the Cloud SQL instance will be created."
  type        = string
}

variable "database_version" {
  description = "The database version to use."
  type        = string
}

variable "tier" {
  description = "The machine type for the Cloud SQL instance."
  type        = string
}

variable "db_user" {
  description = "The database user name."
  type        = string
}
