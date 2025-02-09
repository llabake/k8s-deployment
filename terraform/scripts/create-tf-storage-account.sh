#!/bin/bash
tf_backend=my-tf-sa-backend
gcloud config set project $1

gsutil mb gs://$1-tfstate
gsutil versioning set on gs://$1-tfstate

# grant the terraform backend service account acces to the backend bucket
gsutil iam ch serviceAccount:"$tf_backend@$1.iam.gserviceaccount.com":objectAdmin gs://"$1-tfstate"
