output "target_group" {
    value = aws_lb_target_group.joe_ritesh_tg.arn
}
output "load_balancer" {
  value = aws_alb.joe_ritesh_application_load.arn
}