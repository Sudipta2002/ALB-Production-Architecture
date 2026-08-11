resource "aws_autoscaling_group" "home" {

  name = "${local.name_prefix}-home-asg"

  min_size = 1

  max_size = 2

  desired_capacity = 1

  vpc_zone_identifier = aws_subnet.private[*].id

  target_group_arns = [
    aws_lb_target_group.home.arn
  ]

  launch_template {

    id = aws_launch_template.home.id

    version = "$Latest"

  }

  health_check_type = "ELB"

  health_check_grace_period = 300

  tag {

    key = "Name"

    value = "${local.name_prefix}-home"

    propagate_at_launch = true

  }

}

resource "aws_autoscaling_group" "images" {

  name = "${local.name_prefix}-images-asg"

  min_size = 1

  max_size = 2

  desired_capacity = 1

  vpc_zone_identifier = aws_subnet.private[*].id

  target_group_arns = [
    aws_lb_target_group.images.arn
  ]

  launch_template {

    id = aws_launch_template.images.id

    version = "$Latest"

  }

}

resource "aws_autoscaling_group" "register" {

  name = "${local.name_prefix}-register-asg"

  min_size = 1

  max_size = 2

  desired_capacity = 1

  vpc_zone_identifier = aws_subnet.private[*].id

  target_group_arns = [
    aws_lb_target_group.register.arn
  ]

  launch_template {

    id = aws_launch_template.register.id

    version = "$Latest"

  }

}