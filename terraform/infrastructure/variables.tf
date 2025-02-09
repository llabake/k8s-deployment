
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
# GKE variables
#--------------------------------------------------------------------------------------------------
variable "gke_cluster_name" {
  description = "GKE cluster name"
  type        = any
  default     = "my-gke-cluster"
}
