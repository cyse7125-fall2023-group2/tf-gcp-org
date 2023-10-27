provider "google" {
  credentials = file(var.credFilePath)
  region      = "us-east1"
}

#Project create
module "project_create" {
  source          = "./modules/createProject"
  org_id          = var.org_id
  project_id      = var.project_id
  project_name    = var.project_name
  services        = var.services
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
  depends_on = [module.project_create]
}

module "vm_create" {
  source = "./modules/virtualMachines"

  project_id           = var.project_id
  vpc_network_id       = module.vpc_network.vpc_network_id
  subnet_id            = module.vpc_network.subnet_id
  gce_ssh_user         = var.gce_ssh_user
  gce_ssh_pub_key_file = var.gce_ssh_pub_key_file
}

module "gke_provisioner" {
  source                   = "./modules/gkeProvisioner"
  project_id               = var.project_id
  bastion_ssh_user         = var.bastion_ssh_user
  bastion_ssh_pub_key_file = var.bastion_ssh_pub_key_file
  vpc_network_name         = module.vpc_network.vpc_network_name
  private_subnetwork_name  = module.vpc_network.private_subnetwork_name
  self_link                = module.vpc_network.self_link
  public_ip_cidr_range     = module.vpc_network.public_ip_cidr_range
  service_account          = module.project_create.service_account
  depends_on               = [module.project_create]

}