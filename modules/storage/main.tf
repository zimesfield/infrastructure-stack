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
  id = var.region
}

resource "linode_object_storage_key" "storage_key" {
  label = var.storage_key

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

# resource "linode_object_storage_object" "object2" {
#   bucket  = linode_object_storage_bucket.mybucket-j1145.label
#   cluster = data.linode_object_storage_cluster.primary.id
#   key     = "freetext-object"
#
#   secret_key = linode_object_storage_key.storagekey.secret_key
#   access_key = linode_object_storage_key.storagekey.access_key
#
#   content          = "This is the content of the Object..."
#   content_type     = "text/plain"
#   content_language = "en"
# }