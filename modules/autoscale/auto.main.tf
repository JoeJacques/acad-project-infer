resource "aws_appautoscaling_target" "acad_joe_ritesh" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.ecs_cluster.name}/${var.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = "arn:aws:iam::603825719481:role/acad-joe-ritesh-role"
  min_capacity = 4
  max_capacity       = 10
}

# Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "memory" {
  name               = "cb_scale_up"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.acad_joe_ritesh.resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = aws_appautoscaling_target.acad_joe_ritesh.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "cpu" {
  name               = "joe-ritesh-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.acad_joe_ritesh.resource_id
  scalable_dimension = aws_appautoscaling_target.acad_joe_ritesh.scalable_dimension
  service_namespace  = aws_appautoscaling_target.acad_joe_ritesh.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 80
  }
}

