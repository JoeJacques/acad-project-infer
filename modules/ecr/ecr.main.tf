
# create an ECR repo
resource "aws_ecr_repository" "ecr_repo" {
  name                 = "acad-joe-ritesh-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
# create a cluster
resource "aws_ecs_cluster" "blog_joe_ritesh" {
  name = "blog-joe-ritesh"
}
# create a task definition
resource "aws_ecs_task_definition" "blog_joe_ritesh" {
  family                = "blog_joe_ritesh"
  container_definitions = file("${path.root}/task_definition.json")
  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE" ]
  cpu = 512
  memory = 1024
  execution_role_arn = "arn:aws:iam::603825719481:role/ecsTaskExecutionRole"
}

# create a service
resource "aws_ecs_service" "blog_joe_ritesh" {
  name = "blog-joe-ritesh"
  cluster = aws_ecs_cluster.blog_joe_ritesh.arn
  launch_type = "FARGATE"

  task_definition = aws_ecs_task_definition.blog_joe_ritesh.arn
  desired_count   = 4
  
  network_configuration {
    security_groups = [var.security_group_id]
    subnets = var.public_subnet_id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group
    container_name = aws_ecs_task_definition.blog_joe_ritesh.family
    container_port = 3000 
  }
}

resource "aws_security_group" "service_security_group" {
   vpc_id = var.vpc_id
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    security_groups = [var.security_group_id]
  }
  egress {
    from_port   = 0 
    to_port     = 0 
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"] 
  }
}