module "workflow_pri_sn" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
  terraform_version = "0.12.28"
  workflows = [
    "lint_pull_request",
    "lint_branch",
    "conftest_pull_request",
    "conftest_branch",
    "terratest_pull_request",
    "terratest_branch",
  ]
}

module "workflow_pub_sn" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pub-sn"
  terraform_version = "0.11.14"
  workflows = [
    "lint_pull_request",
    "lint_branch",
  ]
}

module "workflow_nat_base" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-nat-base"
  terraform_version = "0.11.14"
  workflows = [
    "lint_pull_request",
    "lint_branch",
  ]
}

module "workflow_vpc_base" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-base"
  terraform_version = "0.11.14"
  workflows = [
    "lint_pull_request",
    "lint_branch",
  ]
}

module "workflow_vpc_pub2x_pri2x_dbs2x_no_nat" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "vpc-pub2x-pri2x-dbs2x-no-nat"
  terraform_version = "0.11.14"
  workflows = [
    "lint_pull_request",
    "lint_branch",
  ]
}

module "workflow_vpc_pub3x_pri3x_dbs3x_no_nat" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "vpc-pub2x-pri2x-dbs2x-no-nat"
  terraform_version = "0.11.14"
  workflows = [
    "lint_pull_request",
    "lint_branch",
  ]
}

module "workflow_vpc_ha_2x" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-ha-2x"
  terraform_version = "0.11.14"
  workflows = [
    "lint_pull_request",
    "lint_branch",
  ]
}

module "workflow_vpc_ha_3x" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-vpc-ha-3x"
  terraform_version = "0.11.14"
  workflows = [
    "lint_pull_request",
    "lint_branch",
  ]
}
