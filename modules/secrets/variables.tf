variable "secrets" {
  description = "A list of environment variables to be used in the module"
  type        = list(object({
    name  = string
    value = string
  }))
}
