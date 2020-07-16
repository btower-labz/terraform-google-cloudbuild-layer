terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "btower-labz"
    workspaces {
      name = "terraform-google-cloudbuild-layer"
    }
  }
}
