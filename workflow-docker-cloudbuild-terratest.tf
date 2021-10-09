module "workflow_docker_cloudbuild_terratest_dev" {
  source            = "./modules/terraform-google-btlabz-docker-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "docker-cloudbuild-terratest"
  repo_reference    = "master"
  docker_registry   = "public.ecr.aws/v7k3l7g9"
  docker_repository = "docker-cloudbuild-terratest"
  docker_tag        = "latest"
  workflows = [
    "docker_branch",
  ]
}

module "workflow_docker_cloudbuild_terratest_1_0_x" {
  source            = "./modules/terraform-google-btlabz-docker-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "docker-cloudbuild-terratest"
  repo_reference    = "release/1.0.x"
  docker_registry   = "public.ecr.aws/v7k3l7g9"
  docker_repository = "docker-cloudbuild-terratest"
  docker_tag        = "tf-1.0.x-latest"
  workflows = [
    "docker_branch",
  ]
}

module "workflow_docker_cloudbuild_terratest_0_15_x" {
  source            = "./modules/terraform-google-btlabz-docker-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "docker-cloudbuild-terratest"
  repo_reference    = "release/0.15.x"
  docker_registry   = "public.ecr.aws/v7k3l7g9"
  docker_repository = "docker-cloudbuild-terratest"
  docker_tag        = "tf-0.15.x-latest"
  workflows = [
    "docker_branch",
  ]
}

module "workflow_docker_cloudbuild_terratest_0_14_x" {
  source            = "./modules/terraform-google-btlabz-docker-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "docker-cloudbuild-terratest"
  repo_reference    = "release/0.14.x"
  docker_registry   = "public.ecr.aws/v7k3l7g9"
  docker_repository = "docker-cloudbuild-terratest"
  docker_tag        = "tf-0.14.x-latest"
  workflows = [
    "docker_branch",
  ]
}

module "workflow_docker_cloudbuild_terratest_0_13_x" {
  source            = "./modules/terraform-google-btlabz-docker-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "docker-cloudbuild-terratest"
  repo_reference    = "release/0.13.x"
  docker_registry   = "public.ecr.aws/v7k3l7g9"
  docker_repository = "docker-cloudbuild-terratest"
  docker_tag        = "tf-0.13.x-latest"
  workflows = [
    "docker_branch",
  ]
}

module "workflow_docker_cloudbuild_terratest_0_12_x" {
  source            = "./modules/terraform-google-btlabz-docker-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "docker-cloudbuild-terratest"
  repo_reference    = "release/0.12.x"
  docker_registry   = "public.ecr.aws/v7k3l7g9"
  docker_repository = "docker-cloudbuild-terratest"
  docker_tag        = "tf-0.12.x-latest"
  workflows = [
    "docker_branch",
  ]
}


#module "workflow_vpc_ha_3x_11" {
#  source            = "./modules/terraform-google-btlabz-tf-workflow"
#  project           = data.google_project.project.project_id
#  repo_owner        = "btower-labz"
#  repo_name         = "terraform-aws-btlabz-vpc-ha-3x"
#  repo_reference    = "release/terraform-11"
#  terraform_version = local.tf_latest_minors["0.11"]
#  workflows = [
#    "lint_pull_request",
#    "lint_branch",
#  ]
#}
