resource "google_cloudbuild_trigger" "lint_pr_trigger" {
  provider = google-beta
  project     = data.google_project.project.project_id
  name        = "lint-pr-001"
  description = "lint-pr-001"
  disabled    = false

  ignored_files = [
    "**/*.md",
    "**/LICENSE"
  ]

  github {
    owner = "btower-labz"
    name  = "terraform-aws-btlabz-pri-sn"
    pull_request {
      branch = "master"
      comment_control = "COMMENTS_DISABLED"
    }
  }

  #trigger_template {
  #  branch_name = "master"
  #  repo_name   = "terraform-aws-btlabz-pri-sn"
  #}

  substitutions = {
    _FOO = "bar"
    _BAZ = "qux"
  }

  # filename = ".cloudbuid/lint-pr.yaml"

  build {

    step {

      name = "bash"
      args = ["id"]
      timeout = "30s"

    }

    timeout = "600s"

  }


}
