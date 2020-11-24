provider "aws" {
  region = "var.region"
}

terraform {
    backend "remote" {
        organization = "acad-project"
        workspaces {
          name = "acad-project-infer"
        }
      }
    }
