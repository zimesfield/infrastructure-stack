variable "namespace" {
  description = "The name of the Kubernetes namespace"
  type        = string
}

variable "replicaCount" {
  description = "The number of pods to deploy"
  type        = number
  default     = 1
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

variable "service_name" {
  description = "the service name"
}