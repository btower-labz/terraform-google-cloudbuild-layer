#terraform {
#  required_version = ">= 1.0.4"
#}
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
  required_version = ">= 0.13"
}
