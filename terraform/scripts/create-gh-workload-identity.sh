#!/bin/bash
echo "$1" #project_id 
echo "$2" #WI_POOL_NAME=github-action-pool"
echo "$3" #WI_PROVIDER_NAME=github-action-provider
echo "$4" #REPO_ID=38974867 928551526 llabake/k8s-deployment
echo "$5"  #TERRAFORM_GSA_NAME=my-tf-sa
echo "$6" #Runner SA which has the token creator role runner-sa

Create a Workload Identity Pool:
gcloud iam workload-identity-pools create "$2" \
    --location="global" \
    --display-name="Github Action" \
    --description="Terraform Github Action Workload Identity Pool"


WI_POOL_ID=$(gcloud iam workload-identity-pools describe "$2" \
    --location="global" \
    --format='get(name)')

#Create a Workload Identity Provider with Github in that pool
gcloud iam workload-identity-pools providers create-oidc "$3" \
    --location="global" \
    --workload-identity-pool="$2" \
    --display-name="$3" \
    --allowed-audiences="https://github.com" \
    --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository" \
    --attribute-condition="attribute.repository_id=='$4'" \
    --issuer-uri="https://token.actions.githubusercontent.com"

# get project number
PROJECT_NUMBER=$(gcloud projects describe $(gcloud config get-value core/project) --format=value\(projectNumber\))


# Assign workload identity user perms to the external identity
gcloud iam service-accounts add-iam-policy-binding "serviceAccount:$5@$1.iam.gserviceaccount.com" \
    --role=roles/iam.workloadIdentityUser \
    --member="principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/$WI_POOL_ID/attribute.repository/llabake/k8s-deployment"

gcloud iam service-accounts create "$6" \
    --description="Workload ID Token Creator" \
    --display-name="Workload ID Token Creator" \
    --project="$1"

gcloud iam service-accounts add-iam-policy-binding \
    ""$5"@$1.iam.gserviceaccount.com" \
    --member="serviceAccount:$6@$1.iam.gserviceaccount.com" \
    --role="roles/iam.serviceAccountTokenCreator"
