locals {
  name        = var.name == "" ? "lint-pr-${random_id.name.hex}" : var.name
  description = var.description == "" ? "TFLint-PR: ${var.repo_owner}/${var.repo_name} (TF: ${var.terraform_version})" : var.description
  shared_env = [
    "AWS_REGION=us-east-1",
    "AWS_CONFIG_FILE=/aws/config",
    "AWS_PROFILE=codebuild",
    "AWS_SHARED_CREDENTIALS_FILE=/aws/credentials",
  ]
  terraform_repo  = "hashicorp/terraform"
  terraform_image = "${local.terraform_repo}:${var.terraform_version}"

  shared_volumes = [
    {
      name = "aws"
      path = "/aws"
    }
  ]

  terraform_validate_args = [
    "validate",
    "-no-color",
    length(regexall("^0[[:punct:]]11[[:punct:]].+$", var.terraform_version)) > 0 ? "-check-variables=false" : ""
  ]

}
