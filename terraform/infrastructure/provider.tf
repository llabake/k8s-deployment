terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.19.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.19.0"
    }

  }
}


# provider config for terraform to impersonate service account
provider "google" {
  alias = "impersonate_service_account"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

# get access token for the terraform service account
data "google_service_account_access_token" "terraform_sa" {
  provider               = google.impersonate_service_account
  target_service_account = "my-tf-sa@${var.project}.iam.gserviceaccount.com"
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "3600s"
}

provider "google" {
  project      = var.project
  region       = var.region
  access_token = data.google_service_account_access_token.terraform_sa.access_token
}

provider "google-beta" {
  project      = var.project
  region       = var.region
  access_token = data.google_service_account_access_token.terraform_sa.access_token
}

# provider "kubernetes" {
#   host                   = "https://${module.gke.endpoint}"
#   cluster_ca_certificate = base64decode(module.gke.ca_certificate)
#   token                  = data.google_client_config.default.access_token
# }


# provider "kubectl" {
#   # Configuration options
#   host                   = "https://${module.gke.endpoint}"
#   cluster_ca_certificate = base64decode(module.gke.ca_certificate)
#   token                  = data.google_client_config.default.access_token
#   load_config_file       = false
# }
