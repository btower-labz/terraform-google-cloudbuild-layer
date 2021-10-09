module "workflow_pri_sn_dev" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
  repo_reference    = "master"
  terraform_version = "latest"
  terratest_version = "latest"
  workflows = [
    "lint_pull_request",
    "lint_branch",
    "conftest_pull_request",
    "conftest_branch",
    "terratest_pull_request",
    "terratest_branch",
  ]
}

module "workflow_pri_sn_1_0_x" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
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

module "workflow_pri_sn_15" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
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

module "workflow_pri_sn_14" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
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

module "workflow_pri_sn_13" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
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

module "workflow_pri_sn_12" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
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

module "workflow_pri_sn_11" {
  source            = "./modules/terraform-google-btlabz-tf-workflow"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
  repo_reference    = "release/terraform-0.11.x"
  terraform_version = local.tf_latest_minors["0.11"]
  terratest_version = "tf-0.11.x-latest"
  workflows = [
    "lint_pull_request",
    "lint_branch",
  ]
}

