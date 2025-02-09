#--------------------------------------------------
# Docker Registry in Google Artifact Registry
#--------------------------------------------------

module "artifact-registry" {
  source  = "GoogleCloudPlatform/artifact-registry/google"
  version = "0.3.0"


  project_id    = var.project
  location      = var.location
  description   = "Docker Images Repo"
  format        = "DOCKER"
  repository_id = "k8s-deployment"
  members = {
    writers = ["serviceAccount:my-tf-sa@${var.project}.iam.gserviceaccount.com"],
    # readers = ["serviceAccount:gcp-apps-gke-svc@${var.project}.iam.gserviceaccount.com"]
  }
}
