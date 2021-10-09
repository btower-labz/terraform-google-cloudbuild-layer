module "workflow_vpc_ha_3x_dev" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-ha-3x"
  repo_reference    = "master"
  terraform_version = "latest"
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
  repo_reference    = "release/terraform-15"
  terraform_version = local.tf_latest_minors["0.15"]
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
  repo_reference    = "release/terraform-14"
  terraform_version = local.tf_latest_minors["0.14"]
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
  repo_reference    = "release/terraform-13"
  terraform_version = local.tf_latest_minors["0.13"]
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
  repo_reference    = "release/terraform-12"
  terraform_version = local.tf_latest_minors["0.12"]
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
  repo_reference    = "release/terraform-11"
  terraform_version = local.tf_latest_minors["0.11"]
  workflows = [
    "lint_pull_request",
    "lint_branch",
  ]
}
