resource "kubernetes_storage_class" "mongo_retain" {
  count = data.kubernetes_storage_class.existing_storage.metadata[0].uid != "" ? 0 : 1

  metadata {
    name = "${var.app_name}-storage-retain"
  }
  storage_provisioner    = "linodebs.csi.linode.com"
  reclaim_policy = "Retain"
  lifecycle {
    prevent_destroy = var.prevent_destroy       # don’t delete
    ignore_changes  = [metadata] # skip metadata diffs
  }
  parameters = {
    type = "ext4"
  }
}

data "kubernetes_storage_class" "existing_storage" {
  metadata {
    name = "${var.app_name}-storage-retain"
  }
}
