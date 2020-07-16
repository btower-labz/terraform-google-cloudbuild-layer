module "lint_pr" {
  source     = "./modules/terraform-goole-brlabz-lint-terraform-pr"
  project    = data.google_project.project.project_id
  repo_owner = "btower-labz"
  repo_name  = "terraform-aws-btlabz-pri-sn"
}
