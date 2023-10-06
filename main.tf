provider "google" {
  credentials = file("~/.config/gcloud/service-account-key.json")
  region = "us-east1"
}

#Project create
module "project_create" {
  source = "./modules/createProject"

  org_id       = var.org_id
  project_id   = var.project_id
  project_name = var.project_name
  services     = var.services
}

#Organization policy
module "organization_policy" {
  source = "./modules/organizationPolicy"

  org_id = var.org_id
}

module "vpc_network" {
  source     = "./modules/vpcNetwork"
  project_id = var.project_id
}