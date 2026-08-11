resource "aws_lb" "main" {

  name = "${local.name_prefix}-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = aws_subnet.public[*].id

  enable_deletion_protection = false

  tags = {

    Name = "${local.name_prefix}-alb"

  }

}