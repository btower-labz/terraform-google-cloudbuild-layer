locals {
  name        = var.name == "" ? "docker-pr-${random_id.name.hex}" : var.name
  description = var.description == "" ? "DockerBuild-PR: ${var.repo_owner}/${var.repo_name}" : var.description

  shared_env = [
    // AWS Configuration
    "AWS_REGION=us-east-1",
    "AWS_CONFIG_FILE=/aws/config",
    //"AWS_PROFILE=codebuild",
    "AWS_SHARED_CREDENTIALS_FILE=/aws/credentials",
    "AWS_SDK_LOAD_CONFIG=1",
  ]

  berglas_image = "${var.berglas_repo}:${var.berglas_version}"
  awscli_image  = "${var.awscli_repo}:${var.awscli_version}"

  gcp_secret_path = "${data.google_project.project.project_id}/${var.gcp_secret_name}"

  shared_volumes = [
    {
      name = "aws"
      path = "/aws"
    },
  ]
}
