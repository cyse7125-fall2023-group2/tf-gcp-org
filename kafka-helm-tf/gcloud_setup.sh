#!/bin/bash

gke_cluster="$1"
project_name="$2"
project_id="$3"

gcloud config set project $project_id
gcloud components install gke-gcloud-auth-plugin --quiet
gcloud container clusters get-credentials $gke_cluster --project $project_name --region us-east1
