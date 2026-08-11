#############################################
# VPC
#############################################

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

#############################################
# Public Subnets
#############################################

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = aws_subnet.public[*].id
}

#############################################
# Private Subnets
#############################################

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = aws_subnet.private[*].id
}

#############################################
# Internet Gateway
#############################################

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.igw.id
}

#############################################
# NAT Gateway
#############################################

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.main.id
}

#############################################
# ALB
#############################################

output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = aws_lb.main.dns_name
}

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.main.arn
}

#############################################
# Target Groups
#############################################

output "home_target_group_arn" {
  value = aws_lb_target_group.home.arn
}

output "images_target_group_arn" {
  value = aws_lb_target_group.images.arn
}

output "register_target_group_arn" {
  value = aws_lb_target_group.register.arn
}

#############################################
# Auto Scaling Groups
#############################################

output "home_asg_name" {
  value = aws_autoscaling_group.home.name
}

output "images_asg_name" {
  value = aws_autoscaling_group.images.name
}

output "register_asg_name" {
  value = aws_autoscaling_group.register.name
}

#############################################
# Launch Templates
#############################################

output "home_launch_template_id" {
  value = aws_launch_template.home.id
}

output "images_launch_template_id" {
  value = aws_launch_template.images.id
}

output "register_launch_template_id" {
  value = aws_launch_template.register.id
}