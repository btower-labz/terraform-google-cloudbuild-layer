locals {
  name        = var.name == "" ? "lint-pr-${random_id.name.hex}" : var.name
  description = var.description == "" ? "Lint-PR: ${var.repo_owner}/${var.repo_name}" : var.description
  shared_env = [
    "AWS_REGION=us-east-1",
    "AWS_CONFIG_FILE=/aws/config",
    "AWS_PROFILE=codebuild",
    "AWS_SHARED_CREDENTIALS_FILE=/aws/credentials",
  ]
  terraform_image = "hashicorp/terraform:${var.terraform_version}"

  shared_volumes = [
    {
      name = "aws"
      path = "/aws"
    }
  ]
}
