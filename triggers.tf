resource "google_cloudbuild_trigger" "lint_pr_trigger" {
  project     = data.google_project.project.project_id
  name        = "lint-pr-001"
  description = "lint-pr-001"
  disabled    = false

  ignored_files = [
    "**/*.md",
    "LICENSE"
  ]

  #github {
  #  owner = "btower-labz"
  #  name  = "terraform-aws-btlabz-pri-sn"
  #  pull_request {
  #    branch = "master"
  #  }
#
#  }

  trigger_template {
    branch_name = "master"
    repo_name   = "terraform-aws-btlabz-pri-sn"
  }

  substitutions = {
    _FOO = "bar"
    _BAZ = "qux"
  }

  filename = ".cloudbuid/lint-pr.yaml"

  #timeout = "600s"

}
