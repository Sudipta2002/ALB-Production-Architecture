variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}
variable "alert_email" {
  description = "Email address for CloudWatch alerts"
  type        = string
}

variable "key_pair_name" {
  description = "EC2 Key Pair Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "owner" {
  description = "Owner"
  type        = string
  default     = "Sudipta Ghosh"
}

variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of Public Subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of Private Subnet CIDRs"
  type        = list(string)
}