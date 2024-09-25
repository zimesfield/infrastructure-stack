variable "token" {
  description = "The name of the Kubernetes namespace"
  type        = string
}

variable "region" {
  description = "The region for backend"
  type        = string
}

variable "label" {
  description = "The label for terraform state"
  type        = string
}

variable "storage_key" {
  description = "linode storage key"
  type        = string
}

variable "object_storage_key" {
  description = "object storage key"
  type        = string
}
