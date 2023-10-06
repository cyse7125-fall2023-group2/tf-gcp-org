variable "org_id" {
  type = string
}

variable "project_id" {
  type    = string
  default = "csye7125-cloud-1"
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

variable "credFilePath" {
  type = string
}