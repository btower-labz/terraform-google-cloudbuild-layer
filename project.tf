data "google_project" "project" {
  project_id = var.project
}

resource "google_project_service" "cloudbuild" {
  project = data.google_project.project.id
  service = "cloudbuild.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy = true
}
