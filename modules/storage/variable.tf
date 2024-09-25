variable "token" {
  description = "The name of the Kubernetes namespace"
  type        = string
}

variable "storage_key_label" {
  description = "storage key"
  type        = string
}

variable "storage_bucket_label" {
  description = "storage bucket label"
  type        = string
}


variable "object_storage_key" {
  description = "object storage"
  type        = string
}

variable "storage_region" {
  description = "Storage region id"
  type        = string
}


variable "file_path" {
  description = "The filename path to be stored"
  type        = string
}
