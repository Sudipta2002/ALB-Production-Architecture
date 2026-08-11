resource "aws_launch_template" "home" {

  name_prefix = "${local.name_prefix}-home-"

  image_id = data.aws_ami.amazon_linux.id

  instance_type = "t2.micro"

  key_name = var.key_pair_name

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  user_data = base64encode(file("${path.module}/userdata/home.sh"))

  tag_specifications {

    resource_type = "instance"

    tags = {

      Name = "${local.name_prefix}-home"

    }

  }

}
resource "aws_launch_template" "images" {

  name_prefix = "${local.name_prefix}-images-"

  image_id = data.aws_ami.amazon_linux.id

  instance_type = "t2.micro"

  key_name = var.key_pair_name

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  user_data = base64encode(file("${path.module}/userdata/images.sh"))

  tag_specifications {

    resource_type = "instance"

    tags = {

      Name = "${local.name_prefix}-images"

    }

  }

}

resource "aws_launch_template" "register" {

  name_prefix = "${local.name_prefix}-register-"

  image_id = data.aws_ami.amazon_linux.id

  instance_type = "t2.micro"

  key_name = var.key_pair_name

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  user_data = base64encode(file("${path.module}/userdata/register.sh"))

  tag_specifications {

    resource_type = "instance"

    tags = {

      Name = "${local.name_prefix}-register"

    }

  }

}