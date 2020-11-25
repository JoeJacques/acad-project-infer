
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
}

terraform {
  backend "remote" {
    organization = "terraraform-acad"

    workspaces {
      name = "dev"
    }
  }
}

module "network" {
  source = "./modules/network"
}

module "ecr" {
  source = "./modules/ecr"
  
}