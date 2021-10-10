module "docker_pull_request" {
  source            = "../terraform-google-btlabz-docker-pr"
  disabled          = !contains(var.workflows, "docker_pull_request")
  project           = data.google_project.project.project_id
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  repo_reference    = var.repo_reference
  docker_registry   = var.docker_registry
  docker_repository = var.docker_repository
  docker_tag        = var.docker_tag
  workflow_type     = "PR"
}

module "docker_branch" {
  source            = "../terraform-google-btlabz-docker-pr"
  disabled          = !contains(var.workflows, "docker_branch")
  project           = data.google_project.project.project_id
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  repo_reference    = var.repo_reference
  docker_registry   = var.docker_registry
  docker_repository = var.docker_repository
  docker_tag        = var.docker_tag
  workflow_type     = "BRANCH"
}
