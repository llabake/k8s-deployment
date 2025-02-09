#!/bin/bash
echo "$1"
echo "$2"
tf_backend="$2-backend"

# Create Terraform main service account for use by Terraform repo
gcloud iam service-accounts create "$2" \
    --description="Terraform Service Account" \
    --display-name="Terraform Service Account" \
    --project="$1"

# Create service account for "backend.tf" access to state in buckets
gcloud iam service-accounts create "$tf_backend" \
   --description="Terraform Service Account for backend bucket" \
   --display-name="Terraform Backend Bucket Service Account" \
   --project="$1"

# Attach Terraform service account to policies needed to modify infrastructure
gcloud projects add-iam-policy-binding "$1" \
    --member="serviceAccount:$2@$1.iam.gserviceaccount.com" \
    --role="roles/editor"

gcloud projects add-iam-policy-binding "$1" \
    --member="serviceAccount:$2@$1.iam.gserviceaccount.com" \
    --role="roles/container.admin"

gcloud projects add-iam-policy-binding "$1" \
    --member="serviceAccount:$2@$1.iam.gserviceaccount.com" \
    --role="roles/iam.securityAdmin"

gcloud projects add-iam-policy-binding "$1" \
    --member="serviceAccount:$2@$1.iam.gserviceaccount.com" \
    --role="roles/servicenetworking.networksAdmin"

#For testing locally with impersonation
gcloud iam service-accounts add-iam-policy-binding "$1" \
    --member="user:mmaryraphaella@gmail.com" \
    --role="roles/iam.serviceAccountTokenCreator"
