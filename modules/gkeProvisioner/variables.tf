variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "vpc_network_name" {
  type = string
}

variable "public_subnetwork_name" {
  type    = string
  default = "csye7125-public-subnetwork"
}

variable "private_subnetwork_name" {
  type = string
}

variable "self_link" {
    type = string

}
variable "subnetwork_cidr" {
  type    = string
  description = "CIDR range of your subnetwork, e.g., 10.0.0.0/24"
  default = "10.0.1.0/28"
}
variable "service_account" {
    type    = string

}

variable "public_ip_cidr_range" {
      type    = string
}

variable "bastion_ssh_user" {
      type    = string
}

variable "bastion_ssh_pub_key_file" {
      type    = string
      default = "~/.ssh/bastion-host.pub"
}

variable "image_type" {
        type    = string
       default = "COS_CONTAINERD"
}

variable "gcloud_service_account" {
  type = string
  default = "~/.config/gcloud/service-account-key.json"
}

variable "credFilePath" {
  type = string
  default = "/tmp/service-account-key.json"
}

variable "source_ranges" {
  type = string
  default = "35.235.240.0/20"
}