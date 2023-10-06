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
    network    = var.vpc_network_id
    subnetwork = var.subnet_id
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "GCP VM"
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"

  }
  project = var.project_id

  tags = ["allow-ssh", "test-1"]


  # metadata_startup_script = "echo hi > /test.txt"

}