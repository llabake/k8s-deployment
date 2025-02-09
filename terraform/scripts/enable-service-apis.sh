#!/bin/bash
echo "$1"

gcloud config set project $1

gcloud services enable dns.googleapis.com 

gcloud services enable compute.googleapis.com

gcloud services enable iam.googleapis.com

gcloud services enable sts.googleapis.com

gcloud services enable iamcredentials.googleapis.com

gcloud services enable container.googleapis.com

gcloud services enable artifactregistry.googleapis.com
