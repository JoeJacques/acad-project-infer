provider "aws" {

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
  source = "./network"
}
