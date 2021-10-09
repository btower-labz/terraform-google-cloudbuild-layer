module "terratest_pull_request" {
  source         = "../terraform-google-btlabz-docker-pr"
  disabled       = !contains(var.workflows, "docker_pull_request")
  project        = data.google_project.project.project_id
  repo_owner     = var.repo_owner
  repo_name      = var.repo_name
  repo_reference = var.repo_reference
  workflow_type  = "PR"
}

module "terratest_branch" {
  source         = "../terraform-google-btlabz-docker-pr"
  disabled       = !contains(var.workflows, "docker_branch")
  project        = data.google_project.project.project_id
  repo_owner     = var.repo_owner
  repo_name      = var.repo_name
  repo_reference = var.repo_reference
  workflow_type  = "BRANCH"
}
