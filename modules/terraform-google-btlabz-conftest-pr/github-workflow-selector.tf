// GitHub Workflow type selector.
// See: https://www.terraform.io/docs/providers/google/r/cloudbuild_trigger.html#github
locals {

  // GitHUB Pull Request Workflow
  # TODO: #5 Review comment control options
  pr_workflow = var.workflow_type == "PR" ? tolist([tomap({
    "branch" : var.repo_reference,
    "invert_regex" : var.invert_regex,
    "comment_control" : var.comment_control == "" ? null : var.comment_control,
  })]) : []

  // GitHUB Branch Workflow
  branch_workflow = var.workflow_type == "BRANCH" ? tolist([tomap({
    "branch" : var.repo_reference,
    "invert_regex" : var.invert_regex,
  })]) : []

  // GitHUB Tag Workflow
  tag_workflow = var.workflow_type == "TAG" ? tolist([tomap({
    "tag" : var.repo_reference,
    "invert_regex" : var.invert_regex,
  })]) : []

}
