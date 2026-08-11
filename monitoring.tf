resource "aws_cloudwatch_metric_alarm" "alb_5xx" {

  alarm_name = "${local.name_prefix}-alb-5xx"

  alarm_description = "Alarm when ALB returns too many 5XX responses"

  namespace   = "AWS/ApplicationELB"
  metric_name = "HTTPCode_ELB_5XX_Count"

  statistic = "Sum"
  period    = 60

  comparison_operator = "GreaterThanThreshold"
  threshold           = 10

  evaluation_periods = 2

  dimensions = {
    LoadBalancer = aws_lb.main.arn_suffix
  }
  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "home_unhealthy_targets" {

  alarm_name = "${local.name_prefix}-home-unhealthy-targets"

  alarm_description = "Alarm when a Home target becomes unhealthy"

  namespace   = "AWS/ApplicationELB"
  metric_name = "UnHealthyHostCount"

  statistic = "Maximum"
  period    = 60

  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1

  evaluation_periods = 2

  dimensions = {
    TargetGroup  = aws_lb_target_group.home.arn_suffix
    LoadBalancer = aws_lb.main.arn_suffix
  }
  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "images_unhealthy_targets" {

  alarm_name = "${local.name_prefix}-images-unhealthy-targets"

  alarm_description = "Alarm when an Images target becomes unhealthy"

  namespace   = "AWS/ApplicationELB"
  metric_name = "UnHealthyHostCount"

  statistic = "Maximum"
  period    = 60

  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1

  evaluation_periods = 2

  dimensions = {
    TargetGroup  = aws_lb_target_group.images.arn_suffix
    LoadBalancer = aws_lb.main.arn_suffix
  }
  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "register_unhealthy_targets" {

  alarm_name = "${local.name_prefix}-register-unhealthy-targets"

  alarm_description = "Alarm when a Register target becomes unhealthy"

  namespace   = "AWS/ApplicationELB"
  metric_name = "UnHealthyHostCount"

  statistic = "Maximum"
  period    = 60

  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1

  evaluation_periods = 2

  dimensions = {
    TargetGroup  = aws_lb_target_group.register.arn_suffix
    LoadBalancer = aws_lb.main.arn_suffix
  }
  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "images_cpu_high" {

  alarm_name = "${local.name_prefix}-images-cpu-high"

  alarm_description = "Alarm when Images ASG average CPU exceeds 80%"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  statistic = "Average"
  period    = 300

  comparison_operator = "GreaterThanThreshold"
  threshold           = 80

  evaluation_periods = 2

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.images.name
  }

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]
}


resource "aws_cloudwatch_metric_alarm" "register_cpu_high" {

  alarm_name = "${local.name_prefix}-register-cpu-high"

  alarm_description = "Alarm when Register ASG average CPU exceeds 80%"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  statistic = "Average"
  period    = 300

  comparison_operator = "GreaterThanThreshold"
  threshold           = 80

  evaluation_periods = 2

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.register.name
  }

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "home_cpu_high" {

  alarm_name = "${local.name_prefix}-home-cpu-high"

  alarm_description = "Alarm when Home ASG average CPU exceeds 80%"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  statistic = "Average"
  period    = 300

  comparison_operator = "GreaterThanThreshold"
  threshold           = 80

  evaluation_periods = 2

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.home.name
  }

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]
}

  