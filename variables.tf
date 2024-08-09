variable "project_id" {
  description = "The GCP project ID where resources will be created."
  type        = string
}
variable "region" {
  description = "The GCP region where resources will be created. Default is 'me-central2'."
  type        = string
}
variable "project_prefix" {
  description = "A prefix to be used for naming resources. This helps in identifying resources belonging to the same project or environment."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the DNS zone"
  type        = string
}

variable "visibility" {
  description = "Visibility of the DNS zone. Can be 'public' or 'private'."
  type        = string
  default     = "public"
}

variable "cname_name" {
  description = "Name of the CNAME record"
  type        = string
  default     = ""
}

variable "cname_target" {
  description = "Target of the CNAME record"
  type        = string
  default     = ""
}
