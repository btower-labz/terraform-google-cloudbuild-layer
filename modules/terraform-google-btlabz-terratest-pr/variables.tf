variable "project" {
  type        = string
  description = "Target project"
}

variable "name" {
  type        = string
  description = "Build tribber name"
  default     = ""
}

variable "description" {
  type        = string
  description = "Build tribber name"
  default     = ""
}

variable "terraform_repo" {
  type        = string
  description = "Terraform container repository"
  default     = "hashicorp/terraform"
}

variable "terraform_version" {
  type        = string
  description = "Terraform version"
  default     = "latest"
}

variable "berglas_repo" {
  type        = string
  description = "Berglas repository"
  default     = "europe-docker.pkg.dev/berglas/berglas/berglas"
}

variable "berglas_version" {
  type        = string
  description = "Berglas version"
  default     = "latest"
}

variable "awscli_repo" {
  type        = string
  description = "AWS CLI repository"
  default     = "amazon/aws-cli"
}

variable "awscli_version" {
  type        = string
  description = "AWS CLI version"
  default     = "latest"
}

// The image should contain: golang and terraform.
variable "terratest_repo" {
  type        = string
  description = "TerraTest repository. It should contain terraform and golang."
  default     = "btowerlabz/docker-cloudbuild-terratest"
}

variable "terratest_version" {
  type        = string
  description = "Terratest version"
  default     = "latest"
}

variable "gcp_secret_name" {
  type        = string
  description = "GCP Secret with AWS credentials"
  default     = "aws-terratest-credentials"
}

variable "ignored_files" {
  type        = list
  description = "Files to ignore on PR update"
  default = [
    "**/*.md",
    "**/LICENSE"
  ]
}

variable "repo_owner" {
  type        = string
  description = "GitHUB repository owner"
}

variable "repo_name" {
  type        = string
  description = "GitHUB repositoryname"
}

variable "repo_branch" {
  type        = string
  description = "PR target branch"
  default     = "master"
}

variable "comment_control" {
  type        = string
  description = "Comment control option"
  default     = ""
}

variable "additional_terraform_versions" {
  type        = list
  description = "Additional terraform versions to test with"
  default     = ["latest"]
}

variable "golang_max_proc" {
  type = number
  description = "Golang concurrency for TerraTest"
  default = 1
  validation {
    condition = var.golang_max_proc>0
    error_message = "Golang concurrency should be positive integer."
  }
}

variable "terratest_regions" {
  type = list
  description = "AWS Regions to TerraTest"
  default = ["us-east-1"]
  validation {
    condition = length(var.terratest_regions)>0
    error_message = "At least one region should be specified."
  }
}
