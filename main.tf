provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  token = var.token
  region = var.region
}

# create a vpc
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "acad-ritesh-joe-vpc"
    Owner = "acad-ritesh-joe"
  }
}

# create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "acad-ritesh-joe-igw"
    Owner = "acad-ritesh-joe"
  }
}

# create 2 private subnets
resource "aws_subnet" "private_subnets" {
  count = var.num_subnets
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"

  tags = {
    Name = "acad-ritesh-joe-private-sub ${count.index+1}/${var.num_subnets}"
    Owner = "acad-ritesh-joe"
  }
}

# create 2 private subnets
resource "aws_subnet" "public_subnets" {
  count = var.num_subnets
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.${count.index+2}.0/24"

  tags = {
    Name = "acad-ritesh-joe-public-sub ${count.index+1}/${var.num_subnets}"
    Owner = "acad-ritesh-joe"
  }
}

