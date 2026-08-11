resource "aws_autoscaling_policy" "images_scale" {

  name                   = "${local.name_prefix}-images-scaling"
  autoscaling_group_name = aws_autoscaling_group.images.name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70
  }
}
resource "aws_autoscaling_policy" "home_scale" {

  name                   = "${local.name_prefix}-home-scaling"
  autoscaling_group_name = aws_autoscaling_group.home.name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70
  }
}
resource "aws_autoscaling_policy" "register_scale" {

  name                   = "${local.name_prefix}-register-scaling"
  autoscaling_group_name = aws_autoscaling_group.register.name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70
  }
}

