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
    pull_request {
      branch          = var.repo_branch
      comment_control = var.comment_control
    }
  }

  substitutions = {
    _FOO = "bar"
    _BAZ = "qux"
  }

  build {

    tags = [
      "TF-${var.terraform_version}",
      "TerraTest"
    ]

    timeout = "1200s"

    // Store AWS credentials in the file
    step {
      id   = "aws-credentials"
      name = local.berglas_image
      env = local.shared_env
      entrypoint = "/bin/sh"
      args = [ "-e", "-c", "berglas access sm://${local.gcp_secret_path}>/aws/credentials.json" ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      wait_for = ["-"]
      timeout = "60s"
    }

    // Set default AWS region
    step {
      id   = "aws-configure"
      name = local.awscli_image
      env = local.shared_env
      // TODO: #2 Double demasking TF->GCP
      args = [ "configure", "set", "region", "$$${AWS_REGION}" ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      wait_for = ["-"]
      timeout = "60s"
    }

    // Configure credentials retreival options
    step {
      id   = "aws-process"
      name = local.awscli_image
      env = local.shared_env
      args = [ "configure", "set", "credential_process", "/bin/cat /aws/credentials.json" ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      wait_for = ["aws-configure"]
      timeout = "60s"
    }

    // Validate credentials
    step {
      id   = "aws-who"
      name = local.awscli_image
      env = local.shared_env
      args = [ "sts", "get-caller-identity" ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      wait_for = ["aws-process", "aws-credentials"]
      timeout = "60s"
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
      timeout = "60s"
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
      timeout  = "60s"
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
      timeout  = "60s"
      wait_for = ["terraform-init"]
    }

    step {
      id   = "terratest-go-test-${element(var.terratest_regions,0)}"
      name = local.terratest_image
      env  = concat(local.shared_env, list(
        "GOMAXPROCS=${var.golang_max_proc}",
        "GO111MODULE=on",
        "TERRATEST_REGION=${element(var.terratest_regions,0)}",
      ))
      dir = ".terratest"
      entrypoint = "/bin/bash"
      args = [ "-e", "-o","pipefail", "-c", "go test -v -timeout 30m -count=${var.golang_max_proc} 2>&1 | tee /.terratest/test-report-${element(var.terratest_regions,0)}.log" ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "600s"
      wait_for = ["terraform-validate"]
    }

    step {
      id   = "terratest-log-parser-process-${element(var.terratest_regions,0)}"
      name = local.terratest_image
      env  = local.shared_env
      dir = "/.terratest"
      entrypoint = "/bin/bash"
      args = [ "-e", "-o","pipefail", "-c", "terratest_log_parser -testlog test-report-${element(var.terratest_regions,0)}.log -outputdir ${element(var.terratest_regions,0)}" ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "60s"
      wait_for = ["terratest-go-test-${element(var.terratest_regions,0)}"]
    }

    /*
  - id: terratest-log-parser-test-us-east-1
    name: btowerlabz/docker-cloudbuild-terratest:latest
    entrypoint: /bin/bash
    args: [ '-e', '-o', 'pipefail', '-c', 'ls -la /.terratest || cat /.terratest/us-east-1/summary.log']
    waitFor: [ 'terratest-log-parser-process-us-east-1' ]
    timeout: 60s
    */


    /*
    dynamic "step" {
      for_each = var.additional_terraform_versions
      content {
        name = "${local.terraform_repo}:${step.value}"
        env  = local.shared_env
        args = ["validate", "-json", "-no-color"]
        dynamic "volumes" {
          for_each = local.shared_volumes
          content {
            name = volumes.value["name"]
            path = volumes.value["path"]
          }
        }
        timeout  = "60s"
        wait_for = ["terraform-init"]
      }
    }
    */

  }

}
