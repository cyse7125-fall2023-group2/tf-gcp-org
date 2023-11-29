provider "google" {
  credentials = file(var.credFilePath)
  region      = "us-east1"
}

resource "google_project" "project" {
  name                = var.project_name
  project_id          = var.project_id
  org_id              = var.org_id
  auto_create_network = false
  billing_account     = var.billing_account
}

resource "google_service_account" "service_account" {
  account_id   = "csye7125-service-account-id"
  display_name = "Service Account"
  project = var.project_id
}

resource "google_project_iam_binding" "role-1" {
  project = var.project_id
  role    = "roles/container.admin"

  members = [
    # "serviceAccount:dev-service-account@elemental-icon-401200.iam.gserviceaccount.com",
      "serviceAccount:${google_service_account.service_account.email}"

  ]
  depends_on = [google_service_account.service_account]

}

resource "google_project_iam_binding" "role-2" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"

  members = [
      "serviceAccount:${google_service_account.service_account.email}"
  ]
  depends_on = [google_service_account.service_account]

}
resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  =  "serviceAccount:${google_service_account.service_account.email}"

}


resource "google_project_service" "api_services" {
  count   = length(var.services)
  project = google_project.project.project_id
  service = var.services[count.index]
}

output "new_project_number" {
  value = google_project.project.number
}

output "service_account" {
  value= google_service_account.service_account.email
}
