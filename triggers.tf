module "lint_pr_pri_sn_0_12_28" {
  source     = "./modules/terraform-goole-brlabz-tflint-pr"
  project    = data.google_project.project.project_id
  repo_owner = "btower-labz"
  repo_name  = "terraform-aws-btlabz-pri-sn"
  terraform_version = "0.12.28"
}

module "lint_pr_pri_sn_0_12_0" {
  source     = "./modules/terraform-goole-brlabz-tflint-pr"
  project    = data.google_project.project.project_id
  repo_owner = "btower-labz"
  repo_name  = "terraform-aws-btlabz-pri-sn"
  terraform_version = "0.12.0"
}

module "lint_pr_pri_sn_latest" {
  source     = "./modules/terraform-goole-brlabz-tflint-pr"
  project    = data.google_project.project.project_id
  repo_owner = "btower-labz"
  repo_name  = "terraform-aws-btlabz-pri-sn"
  terraform_version = "latest"
}
