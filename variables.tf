variable "org_id" {
  type = string
}

variable "project_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "services" {
  default = ["iam.googleapis.com","orgpolicy.googleapis.com", "cloudresourcemanager.googleapis.com"]
}