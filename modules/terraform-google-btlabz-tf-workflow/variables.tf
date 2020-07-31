variable "project" {
  type        = string
  description = "Target project"
}

variable "repo_owner" {
  type        = string
  description = "GitHUB repository owner"
}

variable "repo_name" {
  type        = string
  description = "GitHUB repositoryname"
}

variable "terraform_version" {
  type        = string
  description = "Version of terraform for linting"
  default     = "latest"
}

variable "terratest_regions" {
  type        = list
  description = "Regions to test with terratest"
  default       = ["us-east-1"]
  validation {
    condition     = length(var.terratest_regions) > 0
    error_message = "At least one region should be specified."
  }
}

variable "workflows" {
  type = list
  description = "Workflows to create"
  default = []
}