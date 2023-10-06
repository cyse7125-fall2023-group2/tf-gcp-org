resource "google_compute_instance" "gcp_vm" {
  name         = "test"
  machine_type = "e2-micro"
  zone         = "us-east1-b"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      labels = {
        my_label = "value"
      }
    }
    auto_delete = true
  }

  network_interface {
    network = var.vpc_network_id
    subnetwork = var.subnet_id
  }

  metadata = {
    foo = "GCP VM"
  }
  project = var.project_id

  tags = ["allow-ssh", "test-1"]


  # metadata_startup_script = "echo hi > /test.txt"

}