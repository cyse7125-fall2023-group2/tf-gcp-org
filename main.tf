provider "google" {
  credentials = file(var.credFilePath)
  region = "us-east1"
}

#Project create
module "project_create" {
  source = "./modules/createProject"

  org_id       = var.org_id
  project_id   = var.project_id
  project_name = var.project_name
  services     = var.services
  billing_account = var.billing_account
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