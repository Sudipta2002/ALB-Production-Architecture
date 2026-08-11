resource "aws_lb_target_group" "home" {

  name = "${local.name_prefix}-home"

  port = 80

  protocol = "HTTP"

  target_type = "instance"

  vpc_id = aws_vpc.main.id

  health_check {

    enabled = true

    path = "/"

    protocol = "HTTP"

    matcher = "200"

    interval = 30

    timeout = 5

    healthy_threshold = 2

    unhealthy_threshold = 2

  }

  tags = {

    Name = "${local.name_prefix}-home"

  }

}
resource "aws_lb_target_group" "images" {

  name = "${local.name_prefix}-images"

  port = 80

  protocol = "HTTP"

  target_type = "instance"

  vpc_id = aws_vpc.main.id

  health_check {

    path = "/images"

    matcher = "200"

  }

}
resource "aws_lb_target_group" "register" {

  name = "${local.name_prefix}-register"

  port = 80

  protocol = "HTTP"

  target_type = "instance"

  vpc_id = aws_vpc.main.id

  health_check {

    path = "/register"

    matcher = "200"

  }

}