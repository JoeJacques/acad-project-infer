
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
  target_group = module.application_load.target_group
  vpc_id = module.network.vpc_id 
  }

module "application_load" {
  source = "./modules/application_load"
  subnets = module.network.subnet_id
  vpc_id = module.network.vpc_id 
  security_groups = module.network.sec_group_id 
    
  }
module "autoscale" {
  source = "./modules/autoscale"
  ecs_cluster = module.ecr.ecs_cluster
  ecs_service = module.ecr.ecs_cluster
  }
  

