provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Path to your kubeconfig
  }
}

resource "helm_release" "kafka_helm_release" {
  name       = "kafka-app-release"
  chart      = "../kafka-helm-chart"
#   namespace  = kubernetes_namespace.my_namespace.metadata.0.name
}

resource "null_resource" "run_script" {
  triggers = {
    # This trigger causes the script to run every time Terraform applies.
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "bash gcloud_setup.sh ${var.gke_cluster_name} ${var.project_name} ${var.project_id}"
  }
}