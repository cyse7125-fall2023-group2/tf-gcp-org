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
  ip_cidr_range = "10.0.0.0/28"
  region        =  var.region
  network       = google_compute_network.vpc_network.id
}

// private subnet
# resource "google_compute_subnetwork" "private_subnetwork" {
#   name          = "csye7125-private-subnetwork"
#   ip_cidr_range = "10.0.1.0/28"
#   region        = "us-east1"
#   network       = google_compute_network.vpc_network.id
# }

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
  name                    = "allow-ssh"
  network                 = google_compute_network.vpc_network.name
  project                 = var.project_id
//  source_service_accounts = [var.service-account-email]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["allow-ssh"]
}

// enable dns api in vpc

resource "google_compute_instance" "gcp_vm" {
  name         = "test"
  machine_type = "e2-micro"
  zone         = "us-east1-b"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
    auto_delete = true
  }

  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.public_subnetwork.id
  }

  metadata = {
    foo = "GCP VM"
  }
  project = var.project_id

  tags = ["allow-ssh", "test-1"]


  # metadata_startup_script = "echo hi > /test.txt"

}
