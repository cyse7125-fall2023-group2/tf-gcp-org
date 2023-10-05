provider "google" {
  credentials = file("~/.config/gcloud/service-account-key.json")
}

module "project_create" {
  source = "./modules/createProject"

  org_id       = var.org_id
  project_id   = var.project_id
  project_name = var.project_name
}

module "organization_policy" {
  source = "./modules/organizationPolicy"

  org_id       = var.org_id
}