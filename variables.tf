variable "org_id" {
  type    = string
  default = "229243752389"
}

variable "project_id" {
  type    = string
  default = "csye7125-cloud-1"
}

variable "project_name" {
  type    = string
  default = "csye7125-cloud"
}

variable "services" {
  default = ["iam.googleapis.com", "orgpolicy.googleapis.com", "cloudresourcemanager.googleapis.com"]
}