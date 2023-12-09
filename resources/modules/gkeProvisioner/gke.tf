data "google_compute_zones" "available_zones" {
  region  = var.region # Change to your desired region
  project = var.project_id

}


resource "google_container_cluster" "primary" {
  name                = "${var.project_id}-gke"
  location            = var.region
  project             = var.project_id
  deletion_protection = false
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.

  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.vpc_network_name
  subnetwork               = var.public_subnetwork_name

  cluster_autoscaling {
    enabled             = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      maximum       = 100
    }

    resource_limits {
      resource_type = "memory"
      minimum       = 1
      maximum       = 100
  }
  }
 # release_channel {
  #   channel = "STABLE" # You can specify "RAPID", "REGULAR", or "STABLE"
  # }

  # node_config {
  #   disk_size_gb = 50
  # }

  # private_cluster_config {
  #   enable_private_endpoint = true
  #   enable_private_nodes    = true
  #   master_ipv4_cidr_block  = "10.13.0.0/28"
  # }
  # ip_allocation_policy {
  #   cluster_ipv4_cidr_block  = "10.11.0.0/21" # K8s pod range
  #   services_ipv4_cidr_block = "10.12.0.0/21" # k8s service range
  # }
  # master_authorized_networks_config {
  #   cidr_blocks {
  #     cidr_block   = var.public_ip_cidr_range
  #     display_name = "net1"
  #   }
  # }
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }


}

resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.primary.name
  location = var.region
  cluster  = google_container_cluster.primary.name
  project  = var.project_id

  node_count     = var.gke_num_nodes
  node_locations = data.google_compute_zones.available_zones.names

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
     "https://www.googleapis.com/auth/devstorage.read_only"
    ]

    preemptible     = true
    service_account = var.service_account
    machine_type    = "e2-small"
    disk_size_gb    = 25
    image_type      = var.image_type
    tags            = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  autoscaling {
    min_node_count = 3
    max_node_count = 6
    
  }
}


resource "random_shuffle" "az" {
  input        = data.google_compute_zones.available_zones.names
  result_count = 1
}


# resource "google_compute_instance" "bastion_host" {
#   project                   = var.project_id
#   zone                      = random_shuffle.az.result[0]
#   name                      = "bastion-host"
#   machine_type              = "e2-medium"
#   allow_stopping_for_update = true
#   tags                      = ["bastion"]
#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }
#   network_interface {
#     network    = var.vpc_network_name
#     subnetwork = var.self_link # Replace with a reference or self link to your subnet, in quotes
#     # network_ip = google_compute_address.my_internal_ip_addr.address
#     access_config {

#     }
#   }
#   metadata = {
#     ssh-keys = "${var.bastion_ssh_user}:${file(var.bastion_ssh_pub_key_file)}"
#   }
#   provisioner "file" {
#     source      = var.gcloud_service_account
#     destination = var.credFilePath
#   }
# }

resource "google_compute_firewall" "rules" {
  project = var.project_id
  name    = "allow-ssh"
  network = var.vpc_network_name # Replace with a reference or self link to your network, in quotes

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [var.my_ip, var.jenkins_ip]
}


# # create cloud router for nat gateway
# resource "google_compute_router" "router" {
#   project = var.project_id
#   name    = "nat-router"
#   network = var.vpc_network_name
#   region  = var.region
# }

## Create Nat Gateway with module

# module "cloud-nat" {
#   source     = "terraform-google-modules/cloud-nat/google"
#   version    = "~> 1.2"
#   project_id = var.project_id
#   region     = var.region
#   router     = google_compute_router.router.name
#   name       = "nat-config"

# }

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}




