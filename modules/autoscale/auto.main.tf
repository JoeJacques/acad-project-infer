resource "aws_appautoscaling_target" "acad_joe_ritesh_dev" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.ecs_cluster.name}/${var.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = "arn:aws:iam::603825719481:role/acad-joe-ritesh-role"
  min_capacity       = 1
  max_capacity       = 10
}
# Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "memory_dev" {
  name               = "cb_scale_up_dev"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.acad_joe_ritesh_dev.resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = aws_appautoscaling_target.acad_joe_ritesh_dev.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 70
  }
}
resource "aws_appautoscaling_policy" "cpu_dev" {
  name               = "joe-ritesh-cpu_dev"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.acad_joe_ritesh_dev.resource_id
  scalable_dimension = aws_appautoscaling_target.acad_joe_ritesh_dev.scalable_dimension
  service_namespace  = aws_appautoscaling_target.acad_joe_ritesh_dev.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 70
  }
}


