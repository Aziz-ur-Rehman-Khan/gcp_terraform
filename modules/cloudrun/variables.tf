variable "name" {
  description = "The name of the Cloud Run service."
  type        = string
}

variable "location" {
  description = "The location where the Cloud Run service will be deployed."
  type        = string
}

variable "container_image" {
  description = "The Docker image to deploy on Cloud Run."
  type        = string
}

variable "max_scale" {
  description = "Maximum number of instances for autoscaling."
  type        = string
}

variable "cloudsql_instance_connection_name" {
  description = "The connection name of the Cloud SQL instance."
  type        = string
}

variable "redis_host" {
  description = "The hostname of the Redis instance."
  type        = string
}

variable "redis_port" {
  description = "The port of the Redis instance."
  type        = number
}

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}