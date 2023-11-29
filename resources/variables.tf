variable "org_id" {
  type = string
}

variable "project_id" {
  type    = string
  default = "csye7125-cloud-8888"
}

# variable "billing_account" {
#   type = string
# }

# variable "project_name" {
#   type    = string
#   default = "csye7125-cloud"
# }

# variable "services" {
#   default = ["iam.googleapis.com", "orgpolicy.googleapis.com",
#     "cloudresourcemanager.googleapis.com",
#     "binaryauthorization.googleapis.com",
#   "container.googleapis.com", "compute.googleapis.com"]
# }

#Cloud Resource Manager API.


variable "gce_ssh_user" {
  type    = string
  default = "vm_user"
}
variable "gce_ssh_pub_key_file" {
  type = string
}

variable "bastion_ssh_user" {
  type = string
}

variable "bastion_ssh_pub_key_file" {
  type    = string
  default = "~/.ssh/bastion-host.pub"

}
variable "credFilePath" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "public_subnetwork_name" {
  type    = string
  default = "csye7125-public-subnetwork"

}

# variable "private_subnetwork_name" {
#   type = string
#   default = "csye7125-private-subnetwork"
# }

# variable "vpc_network_name" {
#   type = string
# }

variable "service_account" {
  type = string
}