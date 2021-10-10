module "lint_pull_request" {
  source            = "../terraform-google-btlabz-tflint-pr"
  disabled          = !contains(var.workflows, "lint_pull_request")
  project           = data.google_project.project.project_id
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  repo_reference    = var.repo_reference
  terraform_version = var.terraform_version
  workflow_type     = "PR"
}

module "lint_branch" {
  source            = "../terraform-google-btlabz-tflint-pr"
  disabled          = !contains(var.workflows, "lint_branch")
  project           = data.google_project.project.project_id
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  repo_reference    = var.repo_reference
  terraform_version = var.terraform_version
  workflow_type     = "BRANCH"
}
