variable "lint_pr" {
  type        = bool
  description = "Create lint pull request workflow"
  default       = false
}

variable "lint_branch" {
  type        = bool
  description = "Create lint branch workflow"
  default       = false
}

variable "conftest_pr" {
  type        = bool
  description = "Create conftest pull request workflow"
  default       = false
}

variable "conftest_branch" {
  type        = bool
  description = "Create conftest branch workflow"
  default       = false
}

variable "terratest_pr" {
  type        = bool
  description = "Create terratest pull request workflow"
  default       = false
}

variable "terratest_branch" {
  type        = bool
  description = "Create terratest branch workflow"
  default       = false
}
