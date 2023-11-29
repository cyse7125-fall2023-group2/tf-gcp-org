variable "org_id" {
  type = string
}

variable "project_id" {
  type    = string
  default = "csye7125-cloud-8888"
}

variable "project_name" {
  type = string
  default = "csye7125-cloud"
}

variable "billing_account" {
  type = string
}

variable "services" {
  type = list(any)
  default = ["iam.googleapis.com", "orgpolicy.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "binaryauthorization.googleapis.com",
  "container.googleapis.com", "compute.googleapis.com"]
}

variable "credFilePath" {
  type = string
}