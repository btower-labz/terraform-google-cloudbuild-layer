variable "project" {
  type        = string
  description = "Target project"
}

variable "name" {
  type        = string
  description = "Build trigger name"
  default     = ""
}

variable "description" {
  type        = string
  description = "Build trigger description"
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
  type        = list(any)
  description = "Files to ignore on PR update"
  default = [
    "**/*.md",
    "**/LICENSE",
    "**/.deepsource.toml",
    "**/.gitignore",
    "**/*.rego"
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

variable "repo_reference" {
  type        = string
  description = "Branch/tag reference for workflow triggering"
  default     = "master"
}

variable "comment_control" {
  type        = string
  description = "Comment control option for PR workflow"
  default     = ""
}

variable "invert_regex" {
  type        = bool
  description = "Revert branch/tag match"
  default     = false
}

variable "workflow_type" {
  type        = string
  description = "Workflow type: PR, BRANCH, TAG"
  default     = "PR"
  validation {
    condition     = length(regexall("^PR|BRANCH|TAG$", var.workflow_type)) > 0
    error_message = "Workflow type should be PR, BRANCH or TAG."
  }
}

variable "additional_terraform_versions" {
  type        = list(any)
  description = "Additional terraform versions to test with"
  default     = ["latest"]
}

variable "golang_max_proc" {
  type        = number
  description = "Golang concurrency for TerraTest"
  default     = 1
  validation {
    condition     = var.golang_max_proc > 0
    error_message = "Golang concurrency should be positive integer."
  }
}

variable "terratest_regions" {
  type        = list(any)
  description = "AWS Regions to TerraTest"
  default     = ["us-east-1"]
  validation {
    condition     = length(var.terratest_regions) > 0
    error_message = "At least one region should be specified."
  }
}

variable "terratest_timeout" {
  type        = number
  description = "TerraTest timeout value in seconds"
  default     = 600
  validation {
    condition     = var.terratest_timeout >= 60
    error_message = "Terraform timeout should be positive value, more than 60 seconds."
  }
}

variable "disabled" {
  type        = bool
  description = "Disable the trigger"
  default     = false
}
