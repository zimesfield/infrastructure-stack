variable "namespace" {
  description = "The name of the Kubernetes namespace"
  type        = string
}
variable "app_name" {
  type        = string
  description = "Application prefix for resource names"
}

variable "prevent_destroy" {
  type        = bool
  default     = true
  description = "Set to false to allow StorageClass destruction"
}

variable "app_version" {
  description = "The version of image"
  type        = string
  default     = "13.2.24"
}
variable "chart" {
  description = "The name of the Kubernetes chart"
  type        = string
  default     = "postgres"
}
variable "database_password" {
  description = "The password of the database"
  type        = string
}
variable "database_username" {
  description = "The name of the db"
  type        = string
}

variable "database_name" {
  description = "The name of the db"
  type        = string
}

variable "root_password" {
  description = "The root password"
  type        = string
}

variable "persistent_size" {
  description = "persistent size"

}
variable "service_port" {
  description = "the port"
}


