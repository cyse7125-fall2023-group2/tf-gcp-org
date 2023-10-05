resource "google_project" "project" {
  name       = "${var.project_name}"
  project_id = "${var.project_id}"
  org_id     = "${var.org_id}"
}

# resource "google_project_service" "cloud_resource_manager" {
#   project = google_project.project.project_id
#   service = "cloudresourcemanager.googleapis.com"

#   timeouts {
#     create = "30m"
#     update = "40m"
#   }

#   disable_dependent_services = true
# }

# resource "google_project_service" "organization_policy" {
#   project = google_project.project.project_id
#   service = "orgpolicy.googleapis.com"

#   timeouts {
#     create = "30m"
#     update = "40m"
#   }

#   disable_dependent_services = true
# }

# resource "google_project_service" "organization_policy" {
#   project = google_project.project.project_id
#   service = "orgpolicy.googleapis.com"
# }

# resource "google_project_service" "cloud_resource_manager" {
#   project = google_project.project.project_id
#   service = "cloudresourcemanager.googleapis.com"
# }