resource "google_project" "project" {
  name                = var.project_name
  project_id          = var.project_id
  org_id              = var.org_id
  auto_create_network = false
  billing_account     = var.billing_account
}


resource "google_project_service" "api_services" {
  count = length(var.services)  
  project = google_project.project.project_id
  service  = var.services[count.index]
}
