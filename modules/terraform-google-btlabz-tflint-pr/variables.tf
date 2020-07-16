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

variable "additional_terraform_versions" {
  type        = list
  description = "Additional terraform versions to test with"
  default     = ["latest"]
}
