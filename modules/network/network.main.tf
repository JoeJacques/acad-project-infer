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

# create 2 public subnets
resource "aws_subnet" "public" {
  count = var.num_subnets
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.${count.index+2}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "acad-ritesh-joe-public-sub ${count.index+1}/${var.num_subnets}"
    Owner = "acad-ritesh-joe"
  }
}

# create route table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "acad-ritesh-joe-rt"
    Owner = "acad-ritesh-joe"
  }
}

# create route table association
resource "aws_route_table_association" "route_table_association" {
  count = 2
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = aws_route_table.route_table.id
}

# create sec group
resource "aws_security_group" "sec_group" {
  vpc_id = aws_vpc.main.id
  
  ingress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  
  tags = {
    Name = "acad-ritesh-joe-sg"
    Owner = "acad-ritesh-joe"
  }
}

# create sec group
resource "aws_security_group" "sec_group_fargate" {
  vpc_id = aws_vpc.main.id
  
  ingress {
    from_port = 0
    to_port = 3000
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "acad-ritesh-joe-sg-fargate"
    Owner = "acad-ritesh-joe"
  }
}