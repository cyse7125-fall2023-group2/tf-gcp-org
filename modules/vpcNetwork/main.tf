//vpc
resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = "vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

// public subnet
resource "google_compute_subnetwork" "public_subnetwork" {
  name          = "csye7125-public-subnetwork"
  project       = var.project_id
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}



// private subnet
resource "google_compute_subnetwork" "private_subnetwork" {
  name          = "csye7125-private-subnetwork"
  project       = var.project_id
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
}

# // cloud router
resource "google_compute_router" "cloud_router" {
  name    = "csye7125-cloud-router"
  project = var.project_id
  network = google_compute_network.vpc_network.name
  bgp {
    asn            = 64514
    advertise_mode = "CUSTOM"
  }
}

resource "google_compute_firewall" "firewall" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name
  project = var.project_id
  //  source_service_accounts = [var.service-account-email]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
}

output "vpc_network_id" {
  value = google_compute_network.vpc_network.id
}
output "vpc_network_name" {
  value = google_compute_network.vpc_network.name
}

output "subnet_id" {
  value = google_compute_subnetwork.public_subnetwork.id
}

output "private_subnetwork_name" {
  value = google_compute_subnetwork.private_subnetwork.name
}

output "self_link" {
  value = google_compute_subnetwork.public_subnetwork.self_link
}

output "public_ip_cidr_range" {
  value = google_compute_subnetwork.public_subnetwork.ip_cidr_range
}