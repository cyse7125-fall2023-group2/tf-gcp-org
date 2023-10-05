resource "google_org_policy_policy" "disable_default_network" {
  name   = "organizations/${var.org_id}/policies/compute.skipDefaultNetworkCreation"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = "TRUE"
    }
  }
}

# resource "google_org_policy_policy" "disable_default_network" {
#   org_id  = "${var.org_id}" # Replace with your organization's ID
#   constraint {
#     display_name = "Disable Default Network Creation"
#     name         = "projects/${var.org_id}/constraints/compute.skipDefaultNetworkCreation" # Replace with your organization's ID
#     policy {
#       boolean_policy {
#         enforced = false
#       }
#     }
#   }
# }
