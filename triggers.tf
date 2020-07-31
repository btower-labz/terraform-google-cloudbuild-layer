module "lint_pr_pri_sn" {
  source            = "./modules/terraform-google-btlabz-tflint-pr"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
  terraform_version = "0.12.28"
}

module "lint_branch_pri_sn" {
  source            = "./modules/terraform-google-btlabz-tflint-pr"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
  terraform_version = "0.12.28"
  workflow_type          = "BRANCH"
}

module "conftest_pr_pri_sn" {
  source            = "./modules/terraform-google-btlabz-conftest-pr"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
  terraform_version = "0.12.28"
}

module "conftest_branch_pri_sn" {
  source            = "./modules/terraform-google-btlabz-conftest-pr"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
  terraform_version = "0.12.28"
  workflow_type          = "BRANCH"
}

module "terratest_pr_pri_sn" {
  source            = "./modules/terraform-google-btlabz-terratest-pr"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
  terraform_version = "0.12.28"
  terratest_regions = [
    "us-east-1",
    "eu-west-2",
    "ap-south-1"
  ]
}

module "terratest_branch_pri_sn" {
  source            = "./modules/terraform-google-btlabz-terratest-pr"
  project           = data.google_project.project.project_id
  repo_owner        = "btower-labz"
  repo_name         = "terraform-aws-btlabz-pri-sn"
  terraform_version = "0.12.28"
  terratest_regions = [
    "us-east-1",
    "eu-west-2",
    "ap-south-1"
  ]
  workflow_type = "BRANCH"
}
