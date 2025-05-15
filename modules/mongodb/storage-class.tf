
data "kubernetes_storage_class" "existing" {
  metadata {
    name = "${var.app_name}-storage-retain"
  }
}

resource "kubernetes_storage_class" "mongo_retain" {
  count = length(data.kubernetes_storage_class.existing.metadata) > 0 ? 0 : 1

  metadata {
    name = "${var.app_name}-storage-retain"
    labels = {
      "app.kubernetes.io/name"     = var.app_name                  # app identity :contentReference[oaicite:0]{index=0}
      "app.kubernetes.io/managed-by" = "terraform"
    }
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "false"      # do not override default :contentReference[oaicite:1]{index=1}
    }
  }

  storage_provisioner  = "linodebs.csi.linode.com"                # Linode CSI plugin :contentReference[oaicite:2]{index=2}
  reclaim_policy       = "Retain"                                 # keep PV after PVC deletion :contentReference[oaicite:3]{index=3}
  volume_binding_mode  = "Immediate"                              # bind volumes promptly :contentReference[oaicite:4]{index=4}
  allow_volume_expansion = true                                   # allow PVC resizing :contentReference[oaicite:5]{index=5}

  parameters = {
    type = "ext4"                                                 # filesystem type :contentReference[oaicite:6]{index=6}
    fsType = "ext4"                                              # CSI parameter name alternative :contentReference[oaicite:7]{index=7}
  }

  mount_options = [                                              # mount optimizations
    "noatime",
    "nodiratime"
  ]

  lifecycle {
    prevent_destroy = true                                       # guard against accidental deletion :contentReference[oaicite:8]{index=8}
    ignore_changes  = [metadata]                                 # ignore metadata-only diffs :contentReference[oaicite:9]{index=9}
  }
}

