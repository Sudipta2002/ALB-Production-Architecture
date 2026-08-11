resource "aws_security_group" "alb" {

  name = "${local.name_prefix}-alb-sg"

  description = "Security Group for ALB"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "HTTP"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "${local.name_prefix}-alb-sg"

  }
}

resource "aws_security_group" "ec2" {

  name = "${local.name_prefix}-ec2-sg"

  description = "Security Group for EC2"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "HTTP from ALB"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]

  }

  ingress {

    description = "SSH"

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = ["223.228.21.237/32"]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "${local.name_prefix}-ec2-sg"

  }

}
