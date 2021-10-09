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
  #validation {
  #  condition     = length(regexall("^PR|BRANCH|TAG$", var.workflow_type)) > 0
  #  error_message = "Workflow type should be PR, BRANCH or TAG."
  #}
}

variable "disabled" {
  type        = bool
  description = "Disable the trigger"
  default     = false
}
