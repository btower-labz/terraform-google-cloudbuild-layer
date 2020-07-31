locals {
  name        = var.name == "" ? "terratest-pr-${random_id.name.hex}" : var.name
  description = var.description == "" ? "TerraTest-PR: ${var.repo_owner}/${var.repo_name} (TF: ${var.terraform_version})" : var.description

  shared_env = [
    // AWS Configuration
    "AWS_REGION=us-east-1",
    "AWS_CONFIG_FILE=/aws/config",
    "AWS_PROFILE=codebuild",
    "AWS_SHARED_CREDENTIALS_FILE=/aws/credentials",
    "AWS_SDK_LOAD_CONFIG=1",

    // Terraform configurations
    "TF_LOG_PATH=/.terraform/terraform.log",
    "TF_INPUT=0",
    "TF_DATA_DIR=/.terraform",
    "TF_IN_AUTOMATION=1",

    // Terratest configurations
    "TERRATEST_REGION=us-east-1"

  ]

  terraform_image = "${var.terraform_repo}:${var.terraform_version}"
  berglas_image = "${var.berglas_repo}:${var.berglas_version}"
  awscli_image = "${var.awscli_repo}:${var.awscli_version}"
  terratest_image = "${var.terratest_repo}:${var.terratest_version}"

  gcp_secret_path = "${data.google_project.project.project_id}/${var.gcp_secret_name}"

  shared_volumes = [
    {
      name = "aws"
      path = "/aws"
    },
    {
      name = "terraform"
      path = "/.terraform"
    },
    {
      name = "aws"
      path = "/.terratest"
    }
  ]
}
