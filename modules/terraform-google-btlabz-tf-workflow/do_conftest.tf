module "conftest_pull_request" {
  source            = "../terraform-google-btlabz-conftest-pr"
  disabled          = ! contains(var.workflows, "conftest_pull_request")
  project           = data.google_project.project.project_id
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  terraform_version = var.terraform_version
}

module "conftest_branch" {
  source            = "../terraform-google-btlabz-conftest-pr"
  disabled          = ! contains(var.workflows, "conftest_branch")
  project           = data.google_project.project.project_id
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  terraform_version = var.terraform_version
  workflow_type     = "BRANCH"
}

