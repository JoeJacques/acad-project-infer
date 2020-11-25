
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
  security_group_id = module.network.sec_group_id
  public_subnet_id = module.network.subnet_id
}

output "sg_id" {
  value = module.network.sec_group_id
}

output "subnet_id" {
  value = module.network.subnet_id
}