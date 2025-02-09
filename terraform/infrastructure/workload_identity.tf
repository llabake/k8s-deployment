# locals {
#   workload_identity_configs = {
#     "apps" = {
#       namespace = "apps"
#       roles = [
#         "roles/container.developer",
#         "roles/storage.objectAdmin",
#         "roles/artifactregistry.writer",
#       ],
#     }
#   }
# }

# module "workload_identity" {

#   source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
#   version    = "~>25.0.0"
#   project_id = var.project

#   k8s_sa_name                     = "apps-gke-svc"
#   gcp_sa_name                     = "gcp-apps-gke-svc"
#   name                            = "apps"
#   namespace                       = "apps"
#   roles                           = local.workload_identity_configs.apps.roles
#   automount_service_account_token = true

# }

module "my-app-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version             = "36.0.1"
  project_id = var.project

  k8s_sa_name                     = "apps-gke-svc"
  gcp_sa_name                     = "gcp-apps-gke-svc"
  name                            = "apps"
  namespace                       = "apps"
  roles                           = ["roles/artifactregistry.reader"]
  automount_service_account_token = true
}