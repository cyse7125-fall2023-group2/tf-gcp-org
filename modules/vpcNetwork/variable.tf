variable "project_id" {
  type = string
}

variable "region" {
  type = string
  default = "us-east1"
}

variable "service-account-email" {
  type = string
  default = "dev-service-account@elemental-icon-401200.iam.gserviceaccount.com"
}