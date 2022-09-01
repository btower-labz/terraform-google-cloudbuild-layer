module "workflow_vpc_ha_3x_dev" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-ha-3x"
  repo_reference    = "master"
  terraform_version = "latest"
  terratest_version = "tf-1.0.x-latest"
  workflows = [
    "lint_pull_request",
    "lint_branch",
    "conftest_pull_request",
    "conftest_branch",
    "terratest_pull_request",
    "terratest_branch",
  ]
}

module "workflow_vpc_ha_3x_1_0_x" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-ha-3x"
  repo_reference    = "release/terraform-1.0.x"
  terraform_version = local.tf_latest_minors["1.0"]
  terratest_version = "tf-1.0.x-latest"
  workflows = [
    "lint_pull_request",
    "lint_branch",
    "conftest_pull_request",
    "conftest_branch",
    "terratest_pull_request",
    "terratest_branch",
  ]
}

module "workflow_vpc_ha_3x_15" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-ha-3x"
  repo_reference    = "release/terraform-0.15.x"
  terraform_version = local.tf_latest_minors["0.15"]
  terratest_version = "tf-0.15.x-latest"
  workflows = [
    "lint_pull_request",
    "lint_branch",
    "conftest_pull_request",
    "conftest_branch",
    "terratest_pull_request",
    "terratest_branch",
  ]
}

module "workflow_vpc_ha_3x_14" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-ha-3x"
  repo_reference    = "release/terraform-0.14.x"
  terraform_version = local.tf_latest_minors["0.14"]
  terratest_version = "tf-0.14.x-latest"
  workflows = [
    "lint_pull_request",
    "lint_branch",
    "conftest_pull_request",
    "conftest_branch",
    "terratest_pull_request",
    "terratest_branch",
  ]
}

module "workflow_vpc_ha_3x_13" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-ha-3x"
  repo_reference    = "release/terraform-0.13.x"
  terraform_version = local.tf_latest_minors["0.13"]
  terratest_version = "tf-0.13.x-latest"
  workflows = [
    "lint_pull_request",
    "lint_branch",
    "conftest_pull_request",
    "conftest_branch",
    "terratest_pull_request",
    "terratest_branch",
  ]
}

module "workflow_vpc_ha_3x_12" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-ha-3x"
  repo_reference    = "release/terraform-0.12.x"
  terraform_version = local.tf_latest_minors["0.12"]
  terratest_version = "tf-0.12.x-latest"
  workflows = [
    "lint_pull_request",
    "lint_branch",
    "conftest_pull_request",
    "conftest_branch",
    "terratest_pull_request",
    "terratest_branch",
  ]
}

module "workflow_vpc_ha_3x_11" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-ha-3x"
  repo_reference    = "release/terraform-0.11.x"
  terraform_version = local.tf_latest_minors["0.11"]
  terratest_version = "tf-0.11.x-latest"
  workflows = [
    "lint_pull_request",
    "lint_branch",
  ]
}
