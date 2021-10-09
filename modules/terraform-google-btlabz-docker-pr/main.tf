resource "google_cloudbuild_trigger" "main" {
  provider    = google-beta
  project     = data.google_project.project.project_id
  name        = local.name
  description = local.description
  disabled    = var.disabled

  ignored_files = var.ignored_files

  github {
    owner = var.repo_owner
    name  = var.repo_name

    // GITHub Pull Request workflow
    dynamic "pull_request" {
      for_each = local.pr_workflow
      content {
        branch          = pull_request.value["branch"]
        invert_regex    = pull_request.value["invert_regex"]
        comment_control = pull_request.value["comment_control"]
      }
    }

    // GITHub Branch workflow
    dynamic "push" {
      for_each = local.branch_workflow
      content {
        branch       = push.value["branch"]
        invert_regex = push.value["invert_regex"]
      }
    }

    // GITHub Tag workflow
    dynamic "push" {
      for_each = local.tag_workflow
      content {
        tag          = push.value["tag"]
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
      #"TF-${var.terraform_version}",
      "DockerBuld"
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

    step {
      id         = "aws-ecr"
      name       = local.awscli_image
      env        = local.shared_env
      entrypoint = "bash"
      args = ["-c",
        "aws ecr-public get-login-password --region us-east-1 >/aws/ecr-login.txt"
      ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      wait_for = ["aws-who"]
      timeout  = "${local.default_timeout}s"
    }


    step {
      id         = "docker-login"
      name       = "gcr.io/cloud-builders/docker"
      env        = local.shared_env
      entrypoint = "bash"
      args = ["-c",
        "cat /aws/ecr-login.txt | docker login --username AWS --password-stdin ${var.docker_registry}"
      ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "${local.default_timeout}s"
      wait_for = ["aws-ecr"]
    }

    step {
      id         = "docker-build"
      name       = "gcr.io/cloud-builders/docker"
      env        = local.shared_env
      entrypoint = "bash"
      args = ["-c",
        "docker build -t ${var.docker_registry}/${var.doker_repository}:${var.docker_tag} ."
      ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "${local.docker_build_timeout}s"
      wait_for = ["docker-login"]
    }

    step {
      id         = "docker-push"
      name       = "gcr.io/cloud-builders/docker"
      env        = local.shared_env
      entrypoint = "bash"
      args = ["-c",
        "docker push ${var.docker_registry}/${var.doker_repository}:${var.docker_tag}"
      ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "${local.docker_push_timeout}s"
      wait_for = ["docker-build"]
    }

    step {
      id         = "docker-logout"
      name       = "gcr.io/cloud-builders/docker"
      env        = local.shared_env
      entrypoint = "bash"
      args = ["-c",
        "docker logout ${var.docker_registry}"
      ]
      dynamic "volumes" {
        for_each = local.shared_volumes
        content {
          name = volumes.value["name"]
          path = volumes.value["path"]
        }
      }
      timeout  = "${local.default_timeout}s"
      wait_for = ["docker-push"]
    }
  }
}
