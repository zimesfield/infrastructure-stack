variable "namespace" {
  description = "The name of the Kubernetes namespace"
  type        = string
}
variable "app_version" {
  description = "The version of image"
  type        = string
  default     = "24.0.1"
}
variable "chart" {
  description = "The name of the Kubernetes chart"
  type        = string
  default     = "keycloak"
}
variable "app_name" {
  description = "The name of the app service"
  type        = string
}
variable "db_name" {
  description = "The name of the realm"
}
variable "username" {
  description = "The username to login to keycloak"
  type        = string
}
variable "password" {
  description = "The password for keycloak"
  type        = string
}
variable "db_username" {
  description = "The name of the db"
  type        = string
}
variable "db_host" {
  description = "The external database link"
  type        = string
}

variable "db_port" {
  description = "The external database port"
  type        = string
}

variable "db_password_key" {
  description = "The external database password_key"
  type        = string
}

variable "db_password_secret" {
  description = "The external database password secret"
  type        = string
}
