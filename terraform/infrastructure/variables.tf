
variable "project" {
  type = string
  default = "labake-project"
}

variable "location" {
  type        = string
  description = "The GCP project main gcp location."
  default     = "eu"
}

variable "region" {
  default = "europe-west1" # Choose a region
}

variable "zone_primary" {
  default = "europe-west1-b" # Choose a zone
}

variable "vpc_name" {
  description = "VPC Name for the VPN Connection"
  type        = string
  default     = "project-vpc"
}


#--------------------------------------------------------------------------------------------------
# ArgoCD/GitOps variables
#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
# ArgoCD/GitOps Image Updater variables
#--------------------------------------------------------------------------------------------------
variable "argocd_image_updater_svc_account_name" {
  description = "Workload Identity Service Account for the ArgoCD Image Updater"
  type        = string
  default     = "argo-img-upd"
}

variable "argocd_image_updater_gitops_url" {
  description = "Version Control System URL for the ArgoCD Image Updater"
  type        = string
  default     = ""
}

variable "argocd_image_updater_pull_secret_url" {
  description = "URL for the Docker Registry Secret for the ArgoCD Image Updater"
  type        = string
  default     = "europe-west1-docker.pkg.dev"
}

#--------------------------------------------------------------------------------------------------
# External DNS variables
#--------------------------------------------------------------------------------------------------
# variable "external_dns_domain_filters" {}

# variable "external_dns_exclude_domains" {}

# variable "external_dns_txt_owner_id" {}

variable "external_dns_namespace" {
  default = "external-dns"
}

#--------------------------------------------------------------------------------------------------
# GKE variables
#--------------------------------------------------------------------------------------------------
variable "gke_cluster_name" {
  description = "GKE cluster name"
  type        = any
  default     = "my-gke-cluster"
}

variable "cluster_namespace_names" {
  description = "List of namespaces to create within the cluster. Does not remove any existing namespaces not managed on this list and new namespaces can still be added through any other means. Changing the order of the names in the set would not force a recreation. Namespace names must be unique. This does not check if the namespaces already exists."
  type        = list(string)
  default     = []
}

#https://cloud.google.com/kubernetes-engine/docs/how-to/preemptible-vms
variable "enable_cluster_preemptible" {
  description = "When set to true, VMs only last for 24 hours after creation - similar to spot VMs. Be careful when used for production workloads."
  type        = bool
  default     = false
}

#--------------------------------------------------------------------------------------------------
# Additional Node Pools variables
#--------------------------------------------------------------------------------------------------
variable "additional_nodepools" {
  type        = any
  description = "Define additional nodepools to be created along with the gke default nodepool."
  default     = {}
}

#--------------------------------------------------------------------------------------------------
# Artifact Registry variables
#--------------------------------------------------------------------------------------------------
variable "artifact_registry_repos" {
  type = list(object({
    name     = string
    location = string
  }))
  default = []
}

#--------------------------------------------------------------------------------------------------
# Cloud Storage variables
#--------------------------------------------------------------------------------------------------
# variable "cloud_storage_buckets" {
#   type = object({
#     names                       = list(string)
#     prefix                      = string
#     labels                      = map(string)
#     versioning                  = map(bool)
#     uniform_bucket_level_access = optional(map(bool), {})
#   })
# }

# variable "cloud_storage_workload_identity" {
#   type = list(object({
#     name          = string
#     k8s_namespace = string
#     access = list(object({
#       name = string
#       role = string
#     }))
#     })
#   )
# }

# variable "additional_bucket_admins" {
#   type = list(object({
#     bucket_name = string
#     iam_emails  = list(string)
#   }))
#   default     = []
#   description = <<EOF
#     Users or other service accounts that should have object admin access. 
#     the module uses 'google_storage_bucket_iam_binding' to configure IAM  thus,
#     any access granted outside this resource block will be rescinded everytime the pipelin is run.
#     iam emails must be perfixed with the iam account type. eg serviceAccount:, user: ors group: 
#     see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam
#   EOF
# }

# variable "additional_bucket_viewers" {
#   type = list(object({
#     bucket_name = string
#     iam_emails  = list(string)
#   }))
#   default     = []
#   description = "Users or other service accounts that should have object viewer access."
# }

# variable "set_viewer_roles" {
#   type        = bool
#   description = "Whether to configure viewer access for the service accounts on the storage buckets"
#   default     = false
# }
# variable "set_admin_roles" {
#   type        = bool
#   description = "Whether to configure object admin access for the service accounts on the storage buckets"
#   default     = true
# }