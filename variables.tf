variable "org_id" {
  type = string
}

variable "project_id" {
  type    = string
  default = "csye7125-cloud-35"
}

variable "billing_account" {
  type = string
}

variable "project_name" {
  type    = string
  default = "csye7125-cloud"
}

variable "services" {
  default = ["iam.googleapis.com", "orgpolicy.googleapis.com", "cloudresourcemanager.googleapis.com"]
}

variable "gce_ssh_user" {
  type = string
  default = "vm_user"
}
variable "gce_ssh_pub_key_file" {
  type = string
}
variable "credFilePath" {
  type = string
}