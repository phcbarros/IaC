terraform {
  cloud {
    organization = "lab-alura-terraform"
    hostname = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {
      name = "aws-terraform"
    }
  }
}