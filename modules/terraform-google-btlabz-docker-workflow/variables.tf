variable "project" {
  type        = string
  description = "Target project"
}

variable "repo_owner" {
  type        = string
  description = "GitHUB repository owner"
  #validation {
  #  condition     = length(var.repo_owner) > 0
  #  error_message = "GitHUB repository owner must be specified."
  #}
}

variable "repo_name" {
  type        = string
  description = "GitHUB repository name"
  #validation {
  #  condition     = length(var.repo_name) > 0
  #  error_message = "GitHUB repository name must be specified."
  #}
}

variable "repo_reference" {
  type        = string
  description = "GitHUB reference name (branch or tag pattern)"
  default     = "master"
  #validation {
  #  condition     = length(var.repo_reference) > 0
  #  error_message = "GitHUB reference name must be specified."
  #}
}

variable "terraform_version" {
  type        = string
  description = "Version of terraform for linting"
  default     = "latest"
}

variable "terratest_regions" {
  type        = list(any)
  description = "Regions to test with terratest"
  default     = ["us-east-1"]
  #validation {
  #  condition     = length(var.terratest_regions) > 0
  #  error_message = "At least one region should be specified."
  #}
}

variable "docker_registry" {
  type        = string
  description = "Docker registry to push image"
}

variable "docker_repository" {
  type        = string
  description = "Docker repository to push"
}

variable "docker_tag" {
  type        = string
  description = "Docker image tag"
  default     = "latest"
}

variable "workflows" {
  type        = list(any)
  description = "Workflows to create"
  default     = []
}
