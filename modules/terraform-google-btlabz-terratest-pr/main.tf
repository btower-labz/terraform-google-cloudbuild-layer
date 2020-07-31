resource "google_cloudbuild_trigger" "main" {
  provider    = google-beta
  project     = data.google_project.project.project_id
  name        = local.name
  description = local.description
  disabled    = false

  ignored_files = var.ignored_files

  github {
    owner = var.repo_owner
    name  = var.repo_name

    // GITHub Pull Request workflow
    dynamic "pull_request" {
      for_each = local.pr_workflow
      content {
        branch = pull_request.value["branch"]
        invert_regex = pull_request.value["invert_regex"]
        comment_control = pull_request.value["comment_control"]
      }
    }

    // GITHub Branch workflow
    dynamic "push" {
      for_each = local.branch_workflow
      content {
        branch = push.value["branch"]
        invert_regex = push.value["invert_regex"]
      }
    }

    // GITHub Tag workflow
    dynamic "push" {
      for_each = local.tag_workflow
      content {
        tag = push.value["tag"]
        invert_regex = push.value["invert_regex"]
      }
    }

  }

  /*
  substitutions = {
    _FOO = "bar"
    _BAZ = "qux"
  }
  */

  build {

    tags = [
      "TF-${var.terraform_version}",
      "TerraTest"
    ]

    timeout = "${local.build_timeout}s"

    // Store AWS credentials in the file
    step {
      id         = "aws-credentials"
      name       = local.berglas_image
      env        = local.shared_env
      entrypoint = "/bin/sh"
      args       = ["-e", "-c", "berglas access sm://${local.gcp_secret_path}>/aws/credentials.json"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      wait_for = ["-"]
      timeout  = "${local.default_timeout}s"
    }

    // Set default AWS region
    step {
      id   = "aws-configure"
      name = local.awscli_image
      env  = local.shared_env
      // TODO: #2 Double demasking TF->GCP
      args = ["configure", "set", "region", "$$${AWS_REGION}"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      wait_for = ["-"]
      timeout  = "${local.default_timeout}s"
    }

    // Configure credentials retreival options
    step {
      id   = "aws-process"
      name = local.awscli_image
      env  = local.shared_env
      args = ["configure", "set", "credential_process", "/bin/cat /aws/credentials.json"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      wait_for = ["aws-configure"]
      timeout  = "${local.default_timeout}s"
    }

    // Validate credentials
    step {
      id   = "aws-who"
      name = local.awscli_image
      env  = local.shared_env
      args = ["sts", "get-caller-identity"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      wait_for = ["aws-process", "aws-credentials"]
      timeout  = "${local.default_timeout}s"
    }

    // Check terraform presense and version
    step {
      id   = "terraform-version"
      name = local.terraform_image
      env  = local.shared_env
      args = ["version"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "${local.default_timeout}s"
      wait_for = ["-"]
    }

    // Initialize module
    step {
      id   = "terraform-init"
      name = local.terraform_image
      env  = local.shared_env
      args = ["init", "-backend=false"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "${local.default_timeout}s"
      wait_for = ["-"]
    }

    // Validate terraform syntax
    step {
      id   = "terraform-validate"
      name = local.terraform_image
      env  = local.shared_env
      args = ["validate", "-json", "-no-color"]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "${local.default_timeout}s"
      wait_for = ["terraform-init"]
    }

    dynamic "step" {
      for_each = var.terratest_regions
      content {
        id   = "terratest-go-test-${step.value}"
        name = local.terratest_image
        env = concat(local.shared_env, list(
          "GOMAXPROCS=${var.golang_max_proc}",
          "GO111MODULE=on",
          "TERRATEST_REGION=${step.value}",
        ))
        dir        = ".terratest"
        entrypoint = "/bin/bash"
        args       = ["-e", "-o", "pipefail", "-c", "go test -v -timeout 30m -count=${var.golang_max_proc} 2>&1 | tee /.terratest/test-report-${step.value}.log"]
        dynamic "volumes" {
          for_each = local.shared_volumes
          content {
            name = volumes.value["name"]
            path = volumes.value["path"]
          }
        }
        timeout  = "${var.terratest_timeout}s"
        wait_for = ["terraform-validate"]
      }
    }

    dynamic "step" {
      for_each = var.terratest_regions
      content {
        id         = "terratest-log-parser-process-${step.value}"
        name       = local.terratest_image
        env        = local.shared_env
        dir        = "/.terratest"
        entrypoint = "/bin/bash"
        args       = ["-e", "-o", "pipefail", "-c", "terratest_log_parser -testlog test-report-${step.value}.log -outputdir ${step.value}"]
        dynamic "volumes" {
          for_each = local.shared_volumes
          content {
            name = volumes.value["name"]
            path = volumes.value["path"]
          }
        }
        timeout  = "${local.default_timeout}s"
        wait_for = ["terratest-go-test-${step.value}"]
      }
    }
  }
}
