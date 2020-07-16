data "google_project" "project" {
  project_id = var.project
}

resource "random_id" "name" {
  keepers = {
    name = "${var.name}"
  }
  byte_length = 8
}
