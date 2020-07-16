data "google_project" "project" {
  project_id = var.project
}


# See: https://github.com/terraform-providers/terraform-provider-google/issues/6486
resource "google_project_service" "cloudbuild" {
  project                    = data.google_project.project.project_id
  service                    = "cloudbuild.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
}

resource "google_project_service" "secretmanager" {
  project                    = data.google_project.project.project_id
  service                    = "secretmanager.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
}

resource "google_project_service" "storage_component" {
  project                    = data.google_project.project.project_id
  service                    = "storage-component.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
}

resource "google_project_service" "storage_api" {
  project                    = data.google_project.project.project_id
  service                    = "storage-api.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
}

resource "google_project_service" "cloudkms" {
  project                    = data.google_project.project.project_id
  service                    = "cloudkms.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
}
