resource "google_cloudbuild_trigger" "main" {
  provider    = google-beta
  project     = data.google_project.project.project_id
  name        = local.name
  description = local.description
  disabled    = false

  ignored_files = var.ignored_files

  github {
    owner = var.repo_owner
    name  = var.repo_name
    pull_request {
      branch          = var.repo_branch
      comment_control = var.comment_control
    }
  }

  substitutions = {
    _FOO = "bar"
    _BAZ = "qux"
  }

  build {

    tags = [
      "FOO",
      "BAR"
    ]

    timeout = "600s"

    step {
      id   = "terraform-version"
      name = local.terraform_image
      env  = local.shared_env
      args = ["version"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout = "60s"
    }

    step {
      id   = "terraform-init"
      name = local.terraform_image
      env  = local.shared_env
      args = ["init", "-backend=false"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "60s"
      wait_for = ["-"]
    }

    step {
      id   = "terraform-validate"
      name = local.terraform_image
      env  = local.shared_env
      args = ["validate", "-json", "-no-color"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "60s"
      wait_for = ["terraform-init"]
    }

    step {
      id   = "terraform-format"
      name = local.terraform_image
      env  = local.shared_env
      args = ["fmt", "-check"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      wait_for = ["terraform-init"]
      timeout  = "60s"
    }


  }

}
