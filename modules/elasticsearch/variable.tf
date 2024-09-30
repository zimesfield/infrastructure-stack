variable "namespace" {
  description = "The name of the Kubernetes namespace"
  type        = string
  default     = "elasticsearch"
}

variable "app_version" {
  description = "The version of image"
  type        = string
  default     = "21.0.0"
}
variable "app_name" {
  description = "The name of the app service"
  type        = string
  default     = "elasticsearch"
}