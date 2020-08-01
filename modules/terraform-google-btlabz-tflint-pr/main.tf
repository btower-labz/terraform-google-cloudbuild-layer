resource "google_cloudbuild_trigger" "main" {
  provider    = google-beta
  project     = data.google_project.project.project_id
  name        = local.name
  description = local.description
  disabled    = var.disabled

  ignored_files = var.ignored_files

  github {
    owner = var.repo_owner
    name  = var.repo_name

    // GITHub Pull Request workflow
    dynamic "pull_request" {
      for_each = local.pr_workflow
      content {
        branch          = pull_request.value["branch"]
        invert_regex    = pull_request.value["invert_regex"]
        comment_control = pull_request.value["comment_control"]
      }
    }

    // GITHub Branch workflow
    dynamic "push" {
      for_each = local.branch_workflow
      content {
        branch       = push.value["branch"]
        invert_regex = push.value["invert_regex"]
      }
    }

    // GITHub Tag workflow
    dynamic "push" {
      for_each = local.tag_workflow
      content {
        tag          = push.value["tag"]
        invert_regex = push.value["invert_regex"]
      }
    }

  }

  # TODO: #7 Make use of substitutions to produce better yaml
  /*
  substitutions = {
    _FOO = "bar"
    _BAZ = "qux"
  }
  */

  build {

    tags = [
      "TF-${var.terraform_version}",
      "TFLint"
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
      # TODO: #1 -json is not supported in older versions
      # args = ["validate", "-json", "-no-color"]
      args = ["validate", "-no-color"]
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

    dynamic "step" {
      for_each = var.additional_terraform_versions
      content {
        name = "${local.terraform_repo}:${step.value}"
        env  = local.shared_env
        # TODO: #1 -json is not supported in older versions
        # args = ["validate", "-json", "-no-color"]
        args = ["validate", "-no-color"]
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
