module "lint_pull_request" {
  source            = "../terraform-google-btlabz-tflint-pr"
  project           = data.google_project.project.project_id
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  terraform_version = var.terraform_version
}

module "lint_branch" {
  source            = "../terraform-google-btlabz-tflint-pr"
  project           = data.google_project.project.project_id
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  terraform_version = var.terraform_version
  workflow_type     = "BRANCH"
}
