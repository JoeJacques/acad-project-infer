resource "aws_alb" "joe_ritesh_application_load_dev" {
  name               = "joe-ritesh-application-load-dev"
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = [var.security_groups]
}
resource "aws_lb_target_group" "joe_ritesh_tg_dev" {
  name        = "acad-joe-ritesh-fargate-tg_dev"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    matcher = "200,301,302"
    path    = "/"
  }
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.joe_ritesh_application_load_dev.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.joe_ritesh_tg_dev.arn
  }
}