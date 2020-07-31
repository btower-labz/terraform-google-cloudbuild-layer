module "terratest_pull_request" {
  source            = "../terraform-google-btlabz-terratest-pr"
  project           = data.google_project.project.project_id
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  terraform_version = var.terraform_version
  terratest_regions = var.terratest_regions
}

module "terratest_branch" {
  source            = "../terraform-google-btlabz-terratest-pr"
  project           = data.google_project.project.project_id
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  terraform_version = var.terraform_version
  terratest_regions = var.terratest_regions
  workflow_type = "BRANCH"
}
