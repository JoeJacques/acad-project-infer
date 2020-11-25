
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
  token= var.token
}

terraform {
  backend "remote" {
    organization = "acad-project"
    workspaces {
      name = "acad-project-infer"
    }
  }
}

module "network" {
  source = "./modules/network"
}

module "ecr" {
  source = "./modules/ecr"
  
}