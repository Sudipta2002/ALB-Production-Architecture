resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.main.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.home.arn

  }

}

resource "aws_lb_listener_rule" "images" {

  listener_arn = aws_lb_listener.http.arn

  priority = 10

  action {

    type = "forward"

    target_group_arn = aws_lb_target_group.images.arn

  }

  condition {

    path_pattern {

      values = ["/images*"]

    }

  }

}
resource "aws_lb_listener_rule" "register" {

  listener_arn = aws_lb_listener.http.arn

  priority = 20

  action {

    type = "forward"

    target_group_arn = aws_lb_target_group.register.arn

  }

  condition {

    path_pattern {

      values = ["/register*"]

    }

  }

}