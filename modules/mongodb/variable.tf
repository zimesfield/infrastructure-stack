variable "external_url" {
  description = "external url"
}

variable "app_version" {
  description = "app version"
}

variable "namespace" {
  description = "namespace"
}

variable "root_username" {
  description = "root username"
}

variable "root_password" {
  description = "root password"
}

variable "database_username" {
  description = "the database username"
}

variable "database_password" {
  description = "database password"
}

variable "database_name" {
  description = "the database name"
}


variable "app_name" {
  description = "the service that requires db name"
}

variable "prevent_destroy" {
  description = "ensure volume is not destroyed"
  default = false
}

variable "service_port" {
  description = "the port"
}

variable "persistent_size" {
  description = "persistent size"

}