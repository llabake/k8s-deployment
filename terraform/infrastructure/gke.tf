module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  version                    = "36.0.1"
  project_id                 = var.project
  name                       = var.gke_cluster_name
  region                     = var.region
  zones                      = [var.zone_primary]
  network                    = module.vpc.network_name
  subnetwork                 = var.zone_primary
  ip_range_pods              = "europe-west1-01-gke-01-pods"
  ip_range_services          = "europe-west1-01-gke-01-services"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  dns_cache                  = false

  node_pools = [
    {
      name                        = "default-node-pool"
      machine_type                = "e2-medium"
      node_locations              = "europe-west1-b"
      min_count                   = 1
      max_count                   = 100
      local_ssd_count             = 0
      spot                        = false
      disk_size_gb                = 100
      disk_type                   = "pd-standard"
      image_type                  = "COS_CONTAINERD"
      enable_gcfs                 = false
      enable_gvnic                = false
      logging_variant             = "DEFAULT"
      auto_repair                 = true
      auto_upgrade                = true
      service_account             = "gcp-apps-gke-svc@${var.project}.iam.gserviceaccount.com"
      preemptible                 = false
      initial_node_count          = 3
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}

# resource "google_project_iam_member" "gke_artifact_registry_viewer" {

#   project = var.project
#   role    = "roles/artifactregistry.reader"
#   member  = "serviceAccount:${var.cluster_0_name_prefix}-${var.env}-${var.cluster_0_region}@${var.project}.iam.gserviceaccount.com"

#   depends_on = [module.gke.endpoint]
# }


resource "kubernetes_namespace" "apps" {
  metadata {
    annotations = {
      name = "applications namepsace"
    }

    labels = {
      mylabel = "my-apps"
    }

    name = "apps"
  }

  depends_on = [ module.gke ]
}