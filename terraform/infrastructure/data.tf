data "google_client_config" "provider" {}
data "google_client_openid_userinfo" "me" { }

# Data block to get information about the GKE cluster
data "google_container_cluster" "gke" {

  name     = module.gke.current_metadata.name # The cluster name
  location = var.region   # The region the cluster is created in

  depends_on = [module.gke]
}
