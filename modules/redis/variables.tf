variable "name" {
  description = "The name of the Redis instance"
  type        = string
}

variable "region" {
  description = "The region to deploy the Redis instance"
  type        = string
}

variable "tier" {
  description = "The service tier of the instance"
  type        = string
  default     = "STANDARD_HA"
}

variable "memory_size_gb" {
  description = "The memory size of the Redis instance in GB"
  type        = number
  default     = 1
}

variable "redis_version" {
  type        = string
  default     = "REDIS_6_X"
}