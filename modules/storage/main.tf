terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "2.28.0"
    }
  }
}

provider "linode" {
  token = var.token
}

data "linode_object_storage_cluster" "primary" {
  id = var.storage_region
}

resource "linode_object_storage_key" "storage_key" {
  label = var.storage_key_label

}

resource "linode_object_storage_bucket" "storage_bucket" {
  cluster    = data.linode_object_storage_cluster.primary.id
  label      = var.storage_bucket_label
  access_key = linode_object_storage_key.storage_key.access_key
  secret_key = linode_object_storage_key.storage_key.secret_key
}

resource "linode_object_storage_object" "object_storage" {
  bucket  = linode_object_storage_bucket.storage_bucket.label
  cluster = data.linode_object_storage_cluster.primary.id
  key     = var.object_storage_key

  secret_key = linode_object_storage_key.storage_key.secret_key
  access_key = linode_object_storage_key.storage_key.access_key

  source = pathexpand(var.file_path)
}

