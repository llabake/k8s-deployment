# Creating Infrastruture for a GCP project


## Prerequisites

- [GCloud CLI](https://cloud.google.com/sdk/docs/install) is installed locally
- Download and install latest [Python](https://www.geeksforgeeks.org/download-and-install-python-3-latest-version/)
- Authenticate into Google Cloud
```bash
gcloud auth login
```
- Install [Terraform](https://www.terraform.io/downloads)

      
## Manually run *create-service-account.sh*
```bash
    cd scripts
    ./create-service-account.sh <GCP Project ID> <required Service Account Name>  
    (e.g. ./create-service-account.sh my-project-id my-tf-sa)
```

This will create the required Service Account in the provided GCP Project, and grant the SA the necessary permissions to execute the operations necessary in further steps.

## Manually run *create-tf-storage-account.sh*
```bash    
    ./create-tf-storage-account.sh <GCP Project ID> 
    (e.g. ./create-tf-storage-account.sh my-project-id)
```

This will create the GCP Storage Account necessary for Terraform Remote State.

## Manually run *enable-service-apis.sh*
```bash
    ./enable-service-apis.sh <GCP Project ID>
    (e.g. ./enable-service-apis.sh my-project-id)
```

This will enable all the required GCP APIs for the rest of the pipelines/configuration.

```bash
    ./create-gh-workload-identity.sh <GCP Project ID>
    POOL_ID="salus-ent-prod-gitlab-runner" PROVIDER_ID="bootstrap-project" BOOTSTRAP_GITLAB_PROJECT_ID="52651570" GOOGLE_PROJECT_ID="salus-enterprise-prod" SERVICE_ACCOUNT_EMAIL="terraform-sa@salus-enterprise-prod.iam.gserviceaccount.com"