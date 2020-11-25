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
  family                = "service"
  container_definitions = file("./task_definition.json")

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-west-1]"
  }
}

# create a service
resource "aws_ecs_service" "blog_joe_ritesh" {
  name = "blog-joe-ritesh"
  cluster = aws_ecs_cluster.blog_joe_ritesh.arn

  task_definition = aws_ecs_task_definition.blog_joe_ritesh.arn
  desired_count   = 1
  # iam_role        = aws_iam_role.foo.arn
  depends_on      = [aws_ecs_task_definition.blog_joe_ritesh.arn]

  network_configuration {
    assign_public_ip = true
    security_groups = aws_security_group.sec_group.id
    subnets = aws_subnet.public.id
  }
}