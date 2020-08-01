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

variable "terraform_version" {
  type        = string
  description = "Version of terraform for linting"
  default     = "latest"
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
  type        = list
  description = "Additional terraform versions to test with"
  default     = []
}

variable "disabled" {
  type        = bool
  description = "Disable the trigger"
  default     = false
}
